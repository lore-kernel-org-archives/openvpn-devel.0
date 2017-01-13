References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
Date: Fri, 13 Jan 2017 11:05:16 +0200
MIME-Version: 1.0
In-Reply-To: <1484297432-14435-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

Il 13/01/2017 10:50, Ilya Shipitsin ha scritto:
> ---
>  .github/PULL_REQUEST_TEMPLATE.md | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 .github/PULL_REQUEST_TEMPLATE.md
>
> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMP=
LATE.md
> new file mode 100644
> index 0000000..d0cfd7f
> --- /dev/null
> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> @@ -0,0 +1,8 @@
> +# Thank you for your contribution
> +
> +You are welcome to open PR, but they are used for discussion only. All
> +patches must eventually go to the openvpn-devel mailing list for review.
> +For details, see these Wiki articles:
> +
> +* https://community.openvpn.net/openvpn/wiki/Contributing
> +* https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
>

Based on testing in the travis-openssl-test repository the template=20
works as intended, so ACK on that part.

Any comments on the text itself?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

