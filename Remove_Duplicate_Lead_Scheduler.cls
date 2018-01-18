global class Remove_Duplicate_Lead_Scheduler implements Schedulable {
	global void execute(SchedulableContext sc){
		DuplicateLeadsRemoval dlr = new DuplicateLeadsRemoval();
	}
}