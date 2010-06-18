Message-ID: <4C1B386E.9000705@...1380...>
Date: Fri, 18 Jun 2010 11:12:14 +0200
From: Emilien Mantel <emilien.mantel@...1380...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Renaming all vars/function "common_name".
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

Related to my previous patch, we talked about renaming all "common_name" 
vars et functions.

My first suggestion was to rename it "username", but it's too vague. 
Alon and David suggested to use "x509_" as prefix for this "new"  var name.

But it seems to me, the server verification is done in the client side. 
The client reads the server's cert too. So I not agree to call it 
"x509_clientid" or "x509_clientref".

I thinked to call it "x509_rdn", but the OpenVPN code doesn't extract 
the RDN (but it's done in most of cases).

I suggest to call it "x509_primary_identifier", it's generic.

If you agree, I can prepare a patch soon based in allmerged tree.

Best regards,

--
Emilien Mantel

