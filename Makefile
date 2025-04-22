OBO = http://purl.obolibrary.org/obo

subset/iba-%.tsv:
	linkml-store -d solr:https://golr.geneontology.org/solr fq -S annotation_class -w "evidence_type: IBA" -O tsv -l 50000 -M $* > $@

subset/iba-slim.terms.txt: subset/iba-1.tsv
	cut -f 2 $< > $@

downloads/go-basic.obo:
	curl -L -s $(OBO)/go/go-basic.obo > $@

subset/iba-slim.obo: subset/iba-slim.terms.txt
	robot extract -i downloads/go-basic.obo --term BFO:0000050 -T $< --method subset -o $@
