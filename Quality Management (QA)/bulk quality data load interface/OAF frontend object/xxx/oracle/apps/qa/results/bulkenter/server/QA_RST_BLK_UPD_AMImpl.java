package xxx.oracle.apps.qa.results.bulkenter.server;


import oracle.apps.fnd.framework.OARow;
import oracle.apps.fnd.framework.OAViewObject;
import oracle.apps.fnd.framework.server.OAApplicationModuleImpl;


import oracle.jbo.Row;
import oracle.jbo.domain.BlobDomain;
import oracle.jbo.RowIterator;
import oracle.jbo.RowSet;
import oracle.apps.fnd.framework.server.OAViewRowImpl;
import oracle.apps.fnd.framework.webui.OAPageContext;

// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class QA_RST_BLK_UPD_AMImpl extends OAApplicationModuleImpl {
    /**This is the default constructor (do not remove)
     */
     
    protected static String C_File_id;
    public QA_RST_BLK_UPD_AMImpl() {
    }

    /**Sample main for debugging Business Components code using the tester.
     */
    public static void main(String[] args) {
        launchTester("xxx.oracle.apps.qa.results.bulkenter.server", /* package name */
      "QA_RST_BLK_UPD_AMLocal" /* Configuration Name */);
    }

    /**Container's getter for QA_RST_BLK_UPD_VO1
     */
    public QA_RST_BLK_UPD_VOImpl getQA_RST_BLK_UPD_VO1() {
        return (QA_RST_BLK_UPD_VOImpl)findViewObject("QA_RST_BLK_UPD_VO1");
    }


    public String createrecord(String file_name, BlobDomain blobDomain)
    {
        RowIterator rowIterator = getXX_FND_BULK_DATA_VO1();
        OAViewObject vo=getXX_FND_BULK_DATA_S_VO1();
        vo.reset();
        vo.next();
        OARow voRow=(OARow)vo.getCurrentRow();
        String File_id="-1";
        if(voRow!=null){
            File_id=(String)voRow.getAttribute("SeqNum");
            
        }
        ((RowSet)rowIterator).setAssociationConsistent(true);
        OAViewRowImpl fndLobsVORowImpl=(OAViewRowImpl)rowIterator.createRow();;
        fndLobsVORowImpl.setAttribute("FileId",File_id);
        fndLobsVORowImpl.setAttribute("FileName",(Object)file_name);
        fndLobsVORowImpl.setAttribute("FileContentType","application/octet-stream");
        fndLobsVORowImpl.setAttribute("FileFormat","binary");
        fndLobsVORowImpl.setAttribute("FileData",(Object)blobDomain);
        rowIterator.insertRow((Row)fndLobsVORowImpl);
        getTransaction().commit();
        vo.executeQuery();
        return File_id;        
    }
    
    public void submitRequest(OAPageContext pageContext){
       
    }
    

    /**Container's getter for XX_FND_BULK_DATA_VO1
     */
    public XX_FND_BULK_DATA_VOImpl getXX_FND_BULK_DATA_VO1() {
        return (XX_FND_BULK_DATA_VOImpl)findViewObject("XX_FND_BULK_DATA_VO1");
    }

    /**Container's getter for XX_FND_BULK_DATA_S_VO1
     */
    public XX_FND_BULK_DATA_S_VOImpl getXX_FND_BULK_DATA_S_VO1() {
        return (XX_FND_BULK_DATA_S_VOImpl)findViewObject("XX_FND_BULK_DATA_S_VO1");
    }

    /**Container's getter for XXCUST_GET_QA_IV_VO1
     */
    public XXCUST_GET_QA_IV_VOImpl getXXCUST_GET_QA_IV_VO1() {
        return (XXCUST_GET_QA_IV_VOImpl)findViewObject("XXCUST_GET_QA_IV_VO1");
    }

    /**Container's getter for xxcust_get_iv_col_vo1
     */
    public xxcust_get_iv_col_voImpl getxxcust_get_iv_col_vo1() {
        return (xxcust_get_iv_col_voImpl)findViewObject("xxcust_get_iv_col_vo1");
    }

    /**Container's getter for XX_WRKR_STATUS_VO1
     */
    public XX_WRKR_STATUS_VOImpl getXX_WRKR_STATUS_VO1() {
        return (XX_WRKR_STATUS_VOImpl)findViewObject("XX_WRKR_STATUS_VO1");
    }

    /**Container's getter for XX_GET_IMPORT_WORKER_VO1
     */
    public XX_GET_IMPORT_WORKER_VOImpl getXX_GET_IMPORT_WORKER_VO1() {
        return (XX_GET_IMPORT_WORKER_VOImpl)findViewObject("XX_GET_IMPORT_WORKER_VO1");
    }
}