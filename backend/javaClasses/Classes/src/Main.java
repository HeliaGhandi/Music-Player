/*
TO-DO-LIST :
    1.USERS RESTORED - USERNAMES RESTORED - EMAILS RESTORED -> move to the message class (ghashang taresh konim masalan har user dar yek khat va ye background mesl json ee ha)
    2.imports replace * -> khas tar
    3.comment haye faz 1 ghabel piade sazi hastand
    4.bad as hame comment haye man sonar qube ha tamoom shan ;)
    5.joda kardan property o folan dar hame class ha
    6.string ha va err code ha hame variable beshan
    7.chand khat javadoc ha <p> haye joda bezanim
    8.sonarqube sonarqube sonarqubeeeeee
 */

import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.network.Server;
import com.lattestudio.musicplayer.util.Message;

class Main{
    public static void main(String[] args) throws Exception {
        Message.cyanServerMessage("USERS RESTORED : " + DataBase.loadUsers());
        Message.cyanServerMessage("USERNAMES RESTORED : "+ DataBase.getUsernames());
        Message.cyanServerMessage("EMAILS RESTORED :" + DataBase.getEmails());

        Server server = new Server();
        server.start();

    }
}