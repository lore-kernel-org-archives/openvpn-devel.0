MIME-Version: 1.0
In-Reply-To: <1328883222-25300-1-git-send-email-heiko.hund@...1489...>
References: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
	<1328883222-25300-1-git-send-email-heiko.hund@...1489...>
Date: Fri, 10 Feb 2012 17:32:10 +0200
Message-ID: <CAOazyz1u+7ijZCcoaPw5oW_E6UcdaiwSQDky2u06XumKLcuzFw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCHv2] handle Windows unicode paths
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Heiko,

I think this patch is important, however as I wrote before it is very
difficult to review when you send it as one chunk.

It is much better if you split this into trivial changes (the
fopen->openvpn_fopen and such) and then focus on each complex change
as in the openssl functions.

The trivial code can be easily merged even without the complete
functionality, slowly making the openvpn Unicode complaint.

The configuration file format is also an issue, if I understand
correctly you force configuration to be UTF-8, while in windows it is
none standard as UCS-2 should used.

Alon.

On Fri, Feb 10, 2012 at 4:13 PM, Heiko Hund <heiko.hund@...1489...> wrote:
>
> Openvpn for Windows is not compiled as a Unicode binary and thus cannot
> handle paths which contain non-ASCII characters using the argv vector.
> Characters that are not present in the system codepage are simply replaced
> with a question mark, e.g. if started as 'openvpn --config =D0=B4=D0=BE=
=D0=BC=D0=BE=D0=B9.ovpn'
> the file '?????.ovpn' is tried to be opened as configuration.
>
> The same applies to paths in config files which need to be UTF-8
> encoded if they contain non ASCII characters. The option line
> 'key =D0=BB=D0=B5=D0=B2.pem' will lead to openvpn trying to open '=C3=90=
=C2=BB=C3=90=C2=B5=C3=90=C2=B2.pem' on a
> system with codepage 1252.
>
> This patch makes openvpn read the command line in UCS-2 and convert
> it to UTF-8 internally. Windows stores names in the filesystem in UCS-2.
> When using a paths openvpn converts it from UTF-8 to UCS-2 and uses the
> wide character Windows API function.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>

