Message-ID: <cc40b1aa-48df-341d-e292-bb399b55dadb@...2080...>
Date: Wed, 15 Jun 2022 15:06:08 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220603095219.637361-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220603095219.637361-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] [OpenVPN 2.5] Allow running a default
 configuration with TLS libraries without BF-CBC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 03/06/2022 11:52, Arne Schwabe wrote:
> Modern TLS libraries might drop Blowfish by default or distributions
> might disable Blowfish in OpenSSL/mbed TLS. We still signal OCC
> options with BF-CBC compatible strings. To avoid requiring BF-CBC
> for this, special this one usage of BF-CBC enough to avoid a hard
> requirement on Blowfish in the default configuration.
> 
> This patch is cherry-picked from 79ff3f79 and the missing
> ciphername = "none"; has been added in the OCC code.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/crypto_backend.h |  2 ++
>   src/openvpn/init.c           | 37 +++++++++++++++++++++------
>   src/openvpn/options.c        | 48 +++++++++++++++++++++++++++++++-----
>   3 files changed, 73 insertions(+), 14 deletions(-)

Just for the record.  This patch has been included into Fedora 36 and 
EPEL-9 builds, released as openvpn-2.5.7-2.

Fedora 36 users has reported that this patch resolves issues which 
surfaced when upgrading to openvpn-2.5.7-1.

A few references:

<https://bodhi.fedoraproject.org/updates/FEDORA-2022-8ca0f56650>
<https://bodhi.fedoraproject.org/updates/FEDORA-EPEL-2022-dd161a4d75>
<https://bugzilla.redhat.com/show_bug.cgi?id=2092800>
<https://bugzilla.redhat.com/show_bug.cgi?id=2093069>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


