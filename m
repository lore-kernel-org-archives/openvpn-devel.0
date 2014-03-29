MIME-Version: 1.0
In-Reply-To: <1396001222-5033-1-git-send-email-arne@...1227...>
References: <1396001222-5033-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 30 Mar 2014 00:48:37 +0100
Message-ID: <CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
Content-Type: multipart/alternative; boundary=001a11c29acc35d29804f5c77628
Subject: Re: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
 tls_serial_{n} is decimal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11c29acc35d29804f5c77628
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Fri, Mar 28, 2014 at 11:07 AM, Arne Schwabe <arne@...1227...> wrote:

> Commit 7d5e26cbb53 fixed extracting serial but did not change the format,
> which always has been decimal. This patch fixes the manpage and
> OSCP.sh script to conform with the implementation.
> ---
> [diff]
>

NACK, because glancing over the code tells me PolarSSL builds do use hex
strings. So this fixes the inconsistency between implementation and manpage
for OpenSSL builds, but adds inconsistency for PolarSSL builds.

I see three options here:
1 - Leave the difference, explain in the manpage.
2 - Change PolarSSL builds to use dec representation
3 - Change OpenSSL builds to use hax representation

I tend towards "just update the manpage". Changing PolarSSL builds to dec
needs changes in PolarSSL, or manually parsing the serial in OpenVPN.
Changing OpenSSL builds to hex is trivial but breaks backward
compatibility. Any other opinions?

-Steffan

--001a11c29acc35d29804f5c77628
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr">Hi,<br><div><div class="gmail_extra"><br><div class="gmail_quote">On Fri, Mar 28, 2014 at 11:07 AM, Arne Schwabe <span dir="ltr">&lt;<a href="mailto:arne@...1227..." target="_blank">arne@...1227...</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>Commit 7d5e26cbb53 fixed extracting serial but did not change the format,<br>
which always has been decimal. This patch fixes the manpage and<br>
OSCP.sh script to conform with the implementation.<br>
---<br></div>
[diff]<span class=""><font color="#888888"><br>
</font></span></blockquote><div><div><div><br>NACK, because glancing over the code tells me PolarSSL builds 
do use hex strings. So this fixes the inconsistency between 
implementation and manpage for OpenSSL builds, but adds inconsistency 
for PolarSSL builds.<br><br></div>I see three options here:<br>1 - Leave the difference, explain in the manpage.<br></div><div>2 - Change PolarSSL builds to use dec representation<br></div><div>3 - Change OpenSSL builds to use hax representation<br>

<br></div><div>I
 tend towards &quot;just update the manpage&quot;. Changing PolarSSL builds to dec
 needs changes in PolarSSL, or manually parsing the serial in OpenVPN. Changing
 OpenSSL builds to hex is trivial but breaks backward compatibility.  Any other opinions?<br><br></div>-Steffan <br></div></div></div></div></div>

--001a11c29acc35d29804f5c77628--

