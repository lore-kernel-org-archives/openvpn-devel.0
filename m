Message-ID: <4936BD57.1090607@...411...>
Date: Wed, 03 Dec 2008 15:09:43 -0200
From: Giancarlo Razzolini <linux-fan@...411...>
MIME-Version: 1.0
Sender: Giancarlo Razzolini <grazzolini@...277...>
Subject: [Openvpn-devel] Port-share + ssh
Reply-To: linux-fan@...411...
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

Hi all,

    I'm trying to use openvpn with the port-share function. As far as i 
could see it only work with http and https. I'm needing it to support 
the ssh protocol as well. I need this because i want to have both 
working on same port. I looked the code in ps.c, mainly the part 
concerning the openvpn protocol detection, but couldn't figure much. 
Just need a point in the right direction or, if someone is working on 
this already, i'm willing to help.

My regards,

-- 
Giancarlo Razzolini
http://lock.razzolini.adm.br
Linux User 172199
Red Hat Certified Engineer no:804006389722501
Verify:https://www.redhat.com/certification/rhce/current/
Moleque Sem Conteudo Numero #002
OpenBSD Stable
Ubuntu 8.04 Hardy Heron
4386 2A6F FFD4 4D5F 5842  6EA0 7ABE BBAB 9C0E 6B85


