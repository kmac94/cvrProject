

use Bio::DB::EUtilities;
use Bio::Tools::EUtilities;
use Bio::Tools::EUtilities::Summary::Item;

my $factory = Bio::DB::EUtilities->new(-eutil => 'esearch',
                                       -db     => 'sra',
                                       -term   => 'public AND controlled',
                                       -email  => '2023085m@student.gla.ac.uk',
                                       -retmax => 50);

# query terms are mapped; what's the actual query?
print "Query translation: ",$factory->get_query_translation,"\n";

# query hits
print "Count = ",$factory->get_count,"\n";

# UIDs
my @ids = $factory->get_ids;
#my @items = $factory-> get_all_Items;

my $factory = Bio::DB::EUtilities->new(-eutil => 'esummary',
                                       -email => '2023085m@student.gla.ac.uk',
                                       -db    => 'sra',
                                       -id    => \@ids);
#print "ID = ",$factory->get_ids,"\n";
#print "Data = ",$factory->get_all_Items,"\n";

								
#while( my $ds = $factory->next_DocSum){
#	print "ID: ",$ds->get_id,"\n";

#	print "Item: ",$ds->get_all_Items,"\n";

#parsing revelant data from XML
#while (my $item = $ds->next_Item) {
 
 #         print "Name: ",$item->get_name,"\n";
#	  print "Type: ",$item->get_type,"\n";
#          print("Data: ",$item->get_contents_by_name,"\n")
#		if $item->get_content;
          
#        while (my $listitem = $ds->next_ListItem) {
            # do stuff here...
#            while (my $listitem = $ds->next_Structure) {
                # do stuff here...
#            }
#        }
#    }




    # flattened mode
#    while (my $item = $ds->next_Item('flattened'))  {
        # not all Items have content, so need to check...
#        printf("%-20s:%s\n",$item->get_name,$item->get_content)
#          if $item->get_content;
#    }

#    print "\n";
#}
while (my $ds = $factory->next_DocSum){
  my ($id,$name,$tile,$platform,$model);
  $id=$ds->get_id;
  while (my $item = $ds->next_Item) {
     print "Name: ",$item->get_name,"\n";
     $name=$item->get_name;
     my $data=$item->get_content;
     print "Type: ",$item->get_type,"\n";
     print "$data\n";
#<Summary><Title>Illumina HiSeq 2500 sequencing</Title><Platform instrument_model="Illumina HiSeq 2500">ILLUMINA</Platform><Statistics total_runs="1" total_spots="2458700" total_bases="159815500" total_size="112179603" load_done="true" cluster_name="public"/></Summary><Submitter acc="ERA886772" center_name="" contact_name="European Nucleotide Archive" lab_name="European Nucleotide Archive"/><Experiment acc="ERX2001348" ver="1" status="public" name="Illumina HiSeq 2500 sequencing"/><Study acc="ERP021057" name="Transposon_directed_insertion_site_sequencing_of_ISS1_libraries_of_Streptococcus_equi_recovered_from_ponies_with_strangles"/><Organism taxid="1336" CommonName="Streptococcus equi strain 4067"/><Sample acc="ERS1505374" name="Streptococcus equi strain 4067"/><Instrument ILLUMINA="Illumina HiSeq 2500"/><Library_descriptor><LIBRARY_NAME>NT928753E</LIBRARY_NAME><LIBRARY_STRATEGY>AMPLICON</LIBRARY_STRATEGY><LIBRARY_SOURCE>GENOMIC</LIBRARY_SOURCE><LIBRARY_SELECTION>PCR</LIBRARY_SELECTION><LIBRARY_LAYOUT> <SINGLE/> </LIBRARY_LAYOUT><LIBRARY_CONSTRUCTION_PROTOCOL>TraDIS pre quality controlled</LIBRARY_CONSTRUCTION_PROTOCOL></Library_descriptor><Bioproject>PRJEB19069</Bioproject><Biosample>SAMEA50444668</Biosample>
     if ($data=~/\<Title\>(.+)\<\/Title\>\<Platform instrument_model\=\"(.+)\"\>(.+)\<\/Platform\>\<Statistics total_runs\=\"(.+)\"\<\/Statistics\>/){
       $title=$1;
       $model=$2;
       $platform=$3;
	$bases=$4;
       	}

#     if($data=~/\<Statistics total_bases\=\"(.+)\"\<\/Statistics\>/){
 #      $bases=$4;
#	}
      # $accession=$5	
             

		
	
   }
   print "\nId $id\nTitle: $title\nPlatform: $platform\nModel: $model\nNumber of Bases: $bases\n";
}