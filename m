MIME-Version: 1.0
In-Reply-To: <20180129082521.GI69387@...1296...>
References: <1516909261-31623-1-git-send-email-selva.nair@...277...>
 <1516909261-31623-2-git-send-email-selva.nair@...277...>
 <20180129082521.GI69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 29 Jan 2018 10:06:31 -0500
Message-ID: <CAKuzo_iCiHX2CgLAb9MuvOgo0_it39OUagrugDK6POA2u_r7xg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Prompt for signature using
 '>PK_SIGN' if the client supports it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Jan 29, 2018 at 3:25 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Thu, Jan 25, 2018 at 02:41:01PM -0500, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - Increase the management version from 1 to 2
>> - If the client announces support for management version > 1
>>   prompt for signature using >PK_SIGN to which the client
>>   responds using 'pk-sig'
>>   Older (current) clients will be continued to be prompted
>>   by '>RSA_SIGN' and can respond using 'rsa-sig'
>> - Remove an unused rsa_sig buffer-list variable
>>
>> This facilitates a transparent transition to PK_SIG and future deprecation
>> of RSA_SIGN
>
> I'm a bit confused about the sequence of patches here.  Is this one dependent
> on one of the other PK_SIGN related patches?  Or standalone and could be
> applied to master "as is"?

Yes this two-patch set is standalone.  Here is a gist:

A: change RSA_SIGN to PK_SIGN if client supports it (2 patches)
-  [Openvpn-devel,1/2] Add management client version
-  [Openvpn-devel,2/2] Prompt for signature using '>PK_SIGN' if the
client supports it

B: ecdsa signature via management (one patch)
- [Openvpn-devel,v3,2/3] Allow external EC key through --management-external-key
(patch 1 of this series already applied, patch 3 abandoned)

A is standalone, B needs A.

In retrospect, I should have just started a new series. The presence
of similar patches for cryptoapicert adds even more to the confusion.
Also getting patchwork to correctly identify v2 of a series would help
a bit. Its failing likely because of the [Openvpn-devel] in our
subject line; if so it could be fixed by a simple patch to patchwork.

Selva

