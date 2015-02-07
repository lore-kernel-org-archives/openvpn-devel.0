references: <CAEsd45SoC+h5tcDraZcQN_MUYzqWYOVvNpkwMo190DLpB32StQ@...278...>
From: Arne Schwabe <arne@...1227...>
message-id: <54D5E234.1090307@...1227...>
Date: Sat, 7 Feb 2015 11:00:20 +0100
mime-version: 1.0
in-reply-to: <CAEsd45SoC+h5tcDraZcQN_MUYzqWYOVvNpkwMo190DLpB32StQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix mismatch of fprintf format
 specifier and argument type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 06.02.2015 20:49, Jonathan K. Bullard wrote:
> This fixes a warning about a mismatch between a fprintf format string
> and an argument type on Darwin-64-bit builds:
>
> %lu specifies type 'unsigned long' but the argument has type
> '__darwin_suseconds_t' (aka 'int')
>
ACK

Arne

