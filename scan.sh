while read hosts;
do
    echo $hosts
    # mkdir -p reports/$TARGET
    # oscap-ssh --sudo vagrant@$TARGET 22 xccdf eval --datastream-id scap_org.open-scap_datastream_from_xccdf_ssg-debian11-xccdf.xml --xccdf-id scap_org.open-scap_cref_ssg-debian11-xccdf.xml --profile xccdf_org.ssgproject.content_profile_anssi_np_nt28_average --oval-results --results reports/$TARGET/xccdf-results.xml --results-arf reports/$TARGET/arf.xml --report reports/$TARGET/report.html /usr/local/share/xml/scap/ssg/content/ssg-debian11-ds.xml || (e=$? && if [[ $e -ne 2 ]]; then exit $e; fi )
done