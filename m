Message-ID: <44F310EF.4020204@...750...>
Date: Mon, 28 Aug 2006 17:51:11 +0200
From: Florent Guiliani <fguiliani@...750...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Can we increase the "push buffer"?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

It appear that the "push buffer" is too small. I've got 34 routes to 
setup to the client. It support up to 28 or 29 only.

I've looked up to the source.
In file option.h we got a:
#define MAX_PUSH_LIST_LEN TLS_CHANNEL_BUF_SIZE /* This parm is related 
to PLAINTEXT_BUFFER_SIZE in ssl.h */

This comment is making me some confuse. Can we change MAX_PUSH_LIST_LEN 
to something like 65535 ?

I've filed a bug report to:
http://sourceforge.net/tracker/index.php?func=detail&aid=1547981&group_id=48978&atid=454719

Florent,


