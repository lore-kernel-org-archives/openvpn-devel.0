References: <20210326160545.26836-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <43c265c8-d504-e8ce-e337-3d23cbf26212@...2181...>
Date: Fri, 26 Mar 2021 17:37:30 +0100
MIME-Version: 1.0
In-Reply-To: <20210326160545.26836-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Always disable TLS renegotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/03/2021 17:05, Arne Schwabe wrote:
> Renegotiations have been troublesome in the past and also the recent OpenSSL
> security problem (CVE-2021-3449) is only exploitable if TLS renegotiation
> is enabled.
> 
> mbed TLS disables it by default and says in the documentation:
> 
> Warning: It is recommended to always disable renegotation unless you know you
> need it and you know what you're doing. In the past, there have been
> several issues associated with renegotiation or a poor understanding of
> its properties.
> 
> TLS renegotiation can be used to restart a session with diffferent

too many f

> parameters (e.g. now with client certs). This somethign that OpenVPN does

somethign -> something

> not use.
> 
> Furthermore because of all these problems, also TLS 1.3 completely
> drops support for renegotiations.
> 
> Patch V2: Improve commments and commit message

too many m :D

> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <antonio@...515...>


Basic connection tests passed, with OpenVPN renegotiations performed
with no issue.

-- 
Antonio Quartulli

