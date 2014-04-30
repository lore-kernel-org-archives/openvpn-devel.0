Message-ID: <5360AC4A.5080406@...515...>
Date: Wed, 30 Apr 2014 01:54:50 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>	<1398064204-26476-4-git-send-email-james@...515...>	<20140427175312.GJ16637@...1296...>	<535D6431.5000308@...1856...>
	<535EC5FE.6060302@...1856...>
In-Reply-To: <535EC5FE.6060302@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
 revert to original versioning approach.
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

On 28/04/2014 15:19, Steffan Karger wrote:
> Hi,
>
> On 27-04-14 22:10, Steffan Karger wrote:
>> On 27-04-14 19:53, Gert Doering wrote:
>>> On Mon, Apr 21, 2014 at 01:10:04AM -0600, James Yonan wrote: The
>>> attached patch is what I intend to commit to release/2.3 *only*,
>>> not to master - as agreed at the IRC meeting.  "Please ACK" :-)
>>
>> Sorry, but NAK.
>
> On a more constructive note: attached a new proposal for this patch.
>
>> The OpenSSL bits look fine
>
> On a closer look, the wrapping "if (tls_version_min > TLS_VER_UNSPEC)"
> in tls_ctx_set_options() seems redundant, because TLS_VER_UNSPEC <
> TLS_VER_1_0 < TLS_VER_1_1 < TLS_VER_1_2 and the ifs are checking for
> "tls_version_min > TLS_VER_1_x". I've removed these changes in the
> attached patch proposal.
>
>> the PolarSSL bits
>> would also allow for SSL_MINOR_VERSION_0, which is SSLv3 and thus a
>> reduction in security (and actually increases the handshake complexity).
>
> To elaborate a bit: The naming is a bit confusing, but
> SSL_MAJOR_VERSION_3 + SSL_MINOR_VERSION_O means SSLv3, ... +
> SSL_MINOR_VERSION_1 means TLSv1.0, ... + SSL_MINOR_VERSION_2 means
> TLSv1.1, etc. If none are given (what would happen in the previous
> version of the patch), PolarSSL defaults the minimum version to SSLv3
> and maximum to TLSv1.2. The attached patch thus removes the wrapping "if
> (tls_version_min > TLS_VER_UNSPEC)" and sets the default to TLSv1.0 to
> TLSv1.2 again. That is equal to the behaviour prior to the TLS
> versioning patch.
>
> -Steffan

This is fine.  I can ACK this.

Thanks,
James


