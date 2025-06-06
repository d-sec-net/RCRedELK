#
# Part of RedELK
# Script to have logstash insert an extra field pointing to the full TXT file of a Cobalt Strike keystrokes file
# Cobalt Strike 4.2 and higher
#
# Author: Outflank B.V. / Marc Smeets
#

def filter(event)
	host = event.get("[agent][name]")
	logpath = event.get("[log][file][path]")
	implant_id = event.get("[implant][id]")
	desktop_session = event.get("[keystrokes][desktop_session]")
	temppath = logpath.split('/cobaltstrike/server')
	temppath2 = temppath[1].split(/\/([^\/]*)$/)
	filename = temppath2[1]
	keystrokespath = "/c2logs/" + "#{host}" + "/cobaltstrike" + "#{temppath2[0]}" + "/" + "#{filename}"
	event.tag("_rubyparseok")
  	event.set("[keystrokes][url]", keystrokespath)
	return [event]
end
