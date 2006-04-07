Message-ID: <4436B9CF.3080202@...75...>
From: Bernd Bartmann <Bernd.Bartmann@...75...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bug in spec-file: init script is overwritten
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Apr  7 12:14:02 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

The openvpn .spec-file supplied in the source code archive does not 
specify "%config(noreplace)" for the init file, i.e. if you run "rpm 
-Uvh openvpn.rpm" and you have a modified init script it is simply 
overwritten without notice. I would expect that the rpm update operation 
either creates a openvpn.rpmsave or openvpn.rpmnew file.

Best regards,
Bernd.


