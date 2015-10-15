In-Reply-To: <mvllur$bcn$1@...1062...>
References: <1444827956-2169-1-git-send-email-arne@...1227...>
	<mvllur$bcn$1@...1062...>
MIME-Version: 1.0
From: David Sommerseth <openvpn.list@...1114...>
Date: Thu, 15 Oct 2015 07:22:46 +0000
Message-ID: <0EC1BD10-AF31-4E30-9F84-14BCD7D1FD31@...1114...>
Subject: Re: [Openvpn-devel] [PATCH V2] Fix
	commit	c67acea173dc9ee37220f5b9ff14ede081181992
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

On 14 October 2015 15:39:39 CEST, Lev Stipakov <lstipakov@...277...> wrote:
>ACK from me. Tested on ics-openvpn, problem with endtag now fixed.
>
>A nitpick. git am says:
>
>/home/stiple/Projects/ics-openvpn/.git/modules/main/openvpn/rebase-apply/p=
atch:20:
>
>trailing whitespace.
>       char *line_ptr =3D line;
>warning: 1 line adds whitespace errors.

Nice catch! However, I believe git am --whitespace=3Dfix fixes those; which=
 our git ack-am script uses.


kind regards,

David Sommerseth

