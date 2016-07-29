MIME-Version: 1.0
In-Reply-To: <CAFdgGSDay1Not+vKh5nVcTXFF04Tvm7Me6wQEdm0U7-GwE5GQw@...278...>
References: <CAFdgGSA_HDUnQCOW8pCGk_UiFZZ9=FBoH1n=4dOy-7t6kF9dOQ@...278...>
	<CAA1Abx+MFJoNwMu6oUGC_BQUaP7WT1S03QzDRy7jKN5ZuMbHww@...278...>
	<CAFdgGSDay1Not+vKh5nVcTXFF04Tvm7Me6wQEdm0U7-GwE5GQw@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 29 Jul 2016 07:51:29 +0200
Message-ID: <CAA1AbxL-nsvnsHtGuhfGfzGq7NhVqqXU2sc6g2bJQ90HW9L7vg@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] tls-cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Yevgeny Kosarzhevsky <phaoost@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, Jul 28, 2016 at 11:28 PM, Yevgeny Kosarzhevsky
<phaoost@...277...> wrote:
> On 25 July 2016 at 12:18, Steffan Karger <steffan@...1856...> wrote:
>> This is likely due to the ECDHE part - this is not supported for
>> OpenVPN 2.3 with OpenSSL (it is for PolarSSL).  Use DHE instead, or
>> switch to the OpenVPN master branch.  The master branch does have
>> ECDH(E) support for OpenSSL too.
>
> I am getting this cipher in the list of supported showed by --show-tls
> option on both sides. So I consider there is something wrong. May be it
> makes sense not to show unsupported ciphers?

Yes, that would make sense, but we can't.  Primarily because OpenSSL
does not provide an interface to do so, but also because we don't know
up front what kind of certificates will be used, and whether OpenVPN
will be run as a client or server (client-side support for ECDH should
work with ovpn-2.3 + openssl too, but I didn't test).

-Steffan

