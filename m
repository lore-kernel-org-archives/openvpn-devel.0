MIME-Version: 1.0
In-Reply-To: <87efkz7k42.fsf@...2274...>
References: <1520185442-22901-1-git-send-email-selva.nair@...277...>
 <87efkz7k42.fsf@...2274...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 4 Mar 2018 14:08:02 -0500
Message-ID: <CAKuzo_jGB0mHc7kKu-pdzTEt3FZst75PL6GKy73A6_eakRh6dw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not assume that
 SSL_CTX_get/set_min/max_proto_version are macros
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Mar 4, 2018 at 1:48 PM, Jeremie Courreges-Anglas <jca@...2272...> wrote:
> On Sun, Mar 04 2018, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> Openssl docs do not explicitly state these to be macros although they
>> are currently defined as such.
>
> Actually they are documented as macros by OpenSSL since day 1, see
> NOTES.

You are right, I missed that in the docs. In that case my patch is not
needed especially so if libressl will provide those macros.

I'm still concerned about set and get functions coming from different
sources and may be we should fix that by requiring that if set is
defined we need get too. But that will once again break libressl
compatibility.

Selva

