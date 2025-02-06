CLASS zbp_r_n_api_new DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zr_n_api_view.
PUBLIC SECTION.
CLASS-DATA mapped_purchase_requisition TYPE RESPONSE FOR MAPPED i_purchaserequisitiontp.
CLASS-DATA mapped_purchase_order TYPE RESPONSE FOR MAPPED i_purchaseordertp_2.
CLASS-DATA mapped_material_document TYPE RESPONSE FOR MAPPED i_materialdocumenttp.
CLASS-DATA mapped_invoice   TYPE RESPONSE FOR MAPPED           i_billingdocumenttp.

CLASS-DATA : it_api type table of ztt_api_master,
             it_kunnr TYPE TABLE of ztt_api_master,
             it_final TYPE TABLE of ztt_api_master.


ENDCLASS.



CLASS ZBP_R_N_API_NEW IMPLEMENTATION.
ENDCLASS.
