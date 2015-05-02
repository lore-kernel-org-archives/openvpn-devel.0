Message-ID: <5545222D.5040004@...1856...>
Date: Sat, 02 May 2015 21:14:53 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1430593625-855-1-git-send-email-gert@...1296...>
In-Reply-To: <1430593625-855-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add note about file permissions and
 --crl-verify to manpage.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 02-05-15 21:07, Gert Doering wrote:
> Trac #522
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   doc/openvpn.8 | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 587b769..24f05bb 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5068,6 +5068,11 @@ is a directory containing files named as revoked serial numbers
>   requests a connection, where the client certificate serial number
>   (decimal string) is the name of a file present in the directory,
>   it will be rejected.
> +
> +Note: As the crl file (or directory) is read every time a peer connects,
> +if you are dropping root privileges with
> +.B --user,
> +make sure that this user has sufficient privileges to read the file.
>   .\"*********************************************************
>   .SS SSL Library information:
>   .\"*********************************************************
>

ACK

-Steffan

