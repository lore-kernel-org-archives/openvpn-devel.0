Message-ID: <4E12BE97.3000308@...1432...>
Date: Tue, 05 Jul 2011 09:34:47 +0200
From: =?ISO-8859-1?Q?Markus_K=F6tter?=
 <koetter@...1432...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Bug: extended x509-username-field broken in git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

"x509-username-field ext:altSubjectName"

does not work on current git - the X509 cert passed to 
extract_x509_extension [1] simply lacks the extension.
The nid for altSubjectName is retrieved correctly (85), but the call to 
X509_get_ext_d2i simply returns no matching extension.

I've had this working with 2.2-beta3 using the patch sent to this ml.
Additionally to testing git, I took the debian 2.2.0 packages (I know 
they add some patches, but nothing which should interfere here), added 
the patch from openvpn git [2], and it did not work either.

The clients openvpn version never changed, so thats not a problem, I 
confirmed the altSubjectNames data is transfered on the wire nevertheless.

I had a look on the diff for 2.2-beta3 to 2.2.0 and saw no suspicious 
changes - maybe because I just don't know how one would suppress the 
extensions from being accessible in the certificate.

So for now I have to use 2.2-beta3.

Suggestions?


Markus

[1] 
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn.git;a=blobdiff;f=ssl.c;h=7b2291c6b3bd86a62ca02830e3fdf3c6f1ac310a;hp=ed107148146a77226df4c60c8e4094da0739ae71;hb=3fa86d237721ca113fa020b7e888a1e10374a560;hpb=338b6948dd52bc0cf2da7e09a29f5127066a7af7

[2] 
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn.git;a=commit;h=3fa86d237721ca113fa020b7e888a1e10374a560

