/*===========================================================================+
 |   Copyright (c) 2001, 2005 Oracle Corporation, Redwood Shores, CA, USA    |
 |                         All rights reserved.                              |
 +===========================================================================+
 |  HISTORY                                                                  |
 +===========================================================================*/
package xxx.oracle.apps.qa.results.bulkenter.webui;

import com.sun.java.util.collections.HashMap;

import com.sun.msv.writer.relaxng.Context;

import java.io.File;

import java.io.IOException;

import oracle.apps.fnd.common.VersionInfo;
import oracle.apps.fnd.framework.webui.OAControllerImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;
import oracle.apps.fnd.framework.webui.beans.OAWebBean;
import oracle.jbo.domain.BlobDomain; 
import java.io.Serializable;
import oracle.apps.fnd.framework.server.OADBTransaction;
import java.util.Vector;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import oracle.apps.fnd.common.MessageToken;
import oracle.apps.fnd.cp.request.ConcurrentRequest;
import oracle.apps.fnd.cp.request.RequestSubmissionException;
import oracle.apps.fnd.framework.OAApplicationModule;
import oracle.apps.fnd.framework.OAException;
import oracle.apps.fnd.framework.OAFwkConstants;
import oracle.apps.fnd.framework.OARow;
import oracle.apps.fnd.framework.OAViewObject;
import oracle.apps.fnd.framework.webui.beans.layout.OAHeaderBean;

/**
 * Controller for ...
 */
public class XXCUST_QA_RST_BLK_UPD_CO extends OAControllerImpl
{
  public static final String RCS_ID="$Header$";
  public static final boolean RCS_ID_RECORDED =
        VersionInfo.recordClassVersion(RCS_ID, "%packagename%");

  /**
   * Layout and page setup logic for a region.
   * @param pageContext the current OA page context
   * @param webBean the web bean corresponding to the region
   */
  
  public void processRequest(OAPageContext pageContext, OAWebBean webBean)
  {
     
    super.processRequest(pageContext, webBean);
    if (pageContext.getParameter("REQUEST") != null) {
        OAException exceptionMessage = new  OAException("Concurrent Request submitted with request_id: "+pageContext.getParameter("REQUEST").toString(),OAException.INFORMATION);
        pageContext.putDialogMessage((OAException)exceptionMessage);
    }
  }

  /**
   * Procedure to handle form submissions for form elements in
   * a region.
   * @param pageContext the current OA page context
   * @param webBean the web bean corresponding to the region
   */
  public void processFormRequest(OAPageContext pageContext, OAWebBean webBean)
  {
    super.processFormRequest(pageContext, webBean);
      String strEvent= pageContext.getParameter(EVENT_PARAM);
      OAApplicationModule oAApplicationModule = pageContext.getApplicationModule(webBean);
      OAException oaexception;
      OARow voRow;
      int request_id=-1;
      if ( strEvent.equals("FILE_UPLOAD")){
            String C_File_id;
            String file_name = pageContext.getParameter("UPLOAD_FILE_NAME");
            BlobDomain blobDomain = (BlobDomain)pageContext.getParameterObject(file_name);
            Serializable parameters[] = {file_name, blobDomain};
            Class paramTypes[] = {String.class, BlobDomain.class};
            C_File_id=(String)oAApplicationModule.invokeMethod("createrecord", parameters, paramTypes);
            pageContext.getApplicationModule(webBean).getTransaction().commit();
            
            
          try{
          Vector<String> vector = new Vector<String>();
          vector.addElement("" + (Object)C_File_id);
          OADBTransaction oADBTransaction = oAApplicationModule.getOADBTransaction();
          ConcurrentRequest concurrentRequest = new ConcurrentRequest(oADBTransaction.getJdbcConnection());
          request_id = concurrentRequest.submitRequest("QA", "XXQABULKRSTUPLD", "", null, false, vector);
          oADBTransaction.commit();
          HashMap hashMap = new HashMap(1);
          hashMap.put((Object)"REQUEST", (Object)("" + request_id + ""));
          pageContext.forwardImmediatelyToCurrentPage(hashMap, false, "N");
          }catch (RequestSubmissionException var16_18) {
                      oaexception = new OAException("Error while submitting Concurrent Request!",OAException.ERROR);
                      pageContext.putDialogMessage(oaexception);
          }
          
      }
      else if( strEvent.equals("FILE_DOWNLOAD")){
          String quality_plan_selected=pageContext.getParameter("QualityPlanLOV");
          if ((quality_plan_selected==null) || quality_plan_selected.equals("")){
              oaexception = new OAException("Please select Quality Plan Name",OAException.ERROR);
              pageContext.putDialogMessage(oaexception);
              
          }
          else{
          String file_content="COLLECTION_PLAN_NAME,ORGANIZATION_CODE,";
          OAViewObject get_qa_iv_vo=(OAViewObject)oAApplicationModule.findViewObject("XXCUST_GET_QA_IV_VO1");
          get_qa_iv_vo.setWhereClause(null);
          get_qa_iv_vo.setWhereClauseParams(null);
          get_qa_iv_vo.setWhereClause("Name=:1 AND Organization_Id=:2");
          get_qa_iv_vo.setWhereClauseParam(0,quality_plan_selected);
          get_qa_iv_vo.setWhereClauseParam(1,"304");
          get_qa_iv_vo.executeQuery();
          voRow=(OARow)get_qa_iv_vo.first();
          String import_view_name=(String)voRow.getAttribute("ImportViewName");
          OAViewObject iv_columns_vo=(OAViewObject)oAApplicationModule.findViewObject("xxcust_get_iv_col_vo1");
          iv_columns_vo.setWhereClause(null);
          iv_columns_vo.setWhereClauseParams(null);
          iv_columns_vo.setWhereClause("Table_Name=:1");
          iv_columns_vo.setWhereClauseParam(0,import_view_name);
          iv_columns_vo.executeQuery();
          voRow=(OARow)iv_columns_vo.first();
          while(iv_columns_vo.hasNext()){
              file_content=file_content+ (String)voRow.getAttribute("ColumnName")+",";
              voRow=(OARow)iv_columns_vo.next();
          }
          
          generate_file(pageContext,quality_plan_selected,file_content);
        }
       }else if ( strEvent.equals("CHECK_WORKER")){
           int rowCount=check_import_worker(oAApplicationModule,request_id);
           if(request_id!=-1){
                if(rowCount==1){
                    oaexception = new OAException("Import Worker completed.",OAException.INFORMATION);
                }
                else{
                    oaexception = new OAException("Import Worker still running.",OAException.INFORMATION);
                }
           }
           else{
               oaexception = new OAException("Please upload the file first.",OAException.ERROR);
           }
           pageContext.putDialogMessage(oaexception);
       }else if ( strEvent.equals("SHOW_ERRORS")){
           int rowCount=check_import_worker(oAApplicationModule,request_id);
           if(request_id!=-1){
                if(rowCount==1){
                    oaexception = new OAException("Import Worker completed.",OAException.INFORMATION);
                }
                else{
                    oaexception = new OAException("Import Worker still running.",OAException.INFORMATION);
                }
           }
           else{
               oaexception = new OAException("Please upload the file first.",OAException.ERROR);
           }
           pageContext.putDialogMessage(oaexception);
       }
      
  }
  
  int check_import_worker(OAApplicationModule oAApplicationModule,Number request_id){
      OAViewObject get_worker_status_vo=(OAViewObject)oAApplicationModule.findViewObject("XX_WRKR_STATUS_VO1");
      get_worker_status_vo.reset();
      get_worker_status_vo.setWhereClause(null);
      get_worker_status_vo.setWhereClauseParams(null);
      get_worker_status_vo.setWhereClause("PHASE_CODE=:1 AND PARENT_REQUEST_ID=:2");
      get_worker_status_vo.setWhereClauseParam(0,"C");
      get_worker_status_vo.setWhereClauseParam(1,request_id);
      get_worker_status_vo.executeQuery();
      return get_worker_status_vo.getRowCount();
  }
  
  void generate_file(OAPageContext pageContext,String File_name,String file_content){
      HttpServletResponse response = (HttpServletResponse)pageContext.getRenderingContext().getServletResponse();
      response.setContentType("application/text");
      response.setHeader("Content-Disposition", "attachment; filename="+File_name+".csv");
      ServletOutputStream pw = null;
      try
      {
          pw = response.getOutputStream();
           pw.println((String)file_content); 
           pw.flush();
           pw.close();
      }
       catch(IOException ioexception)
       {
           ioexception.printStackTrace();
           throw new OAException("Unexpected Exception occurred.Exception Details :"+ioexception.toString());
       }
  }

}
