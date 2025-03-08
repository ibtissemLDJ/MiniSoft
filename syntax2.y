%{
    incl
}

debut : MainPrgm idf pnt_virgul var declaration BeginPg accolade_ouvr instructions accolade_ferm EndPg pnt_virgul ; 
declaration : let variables deux_pnts type pnt_virgul;
variables: idf virgul variables| idf 
type : float | int |corechet_ouvr type pnt_virgul corechet_ferm
instructions :
