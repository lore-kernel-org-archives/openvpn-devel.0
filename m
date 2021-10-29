References: <20211019183127.614175-1-arne@...1227...>
 <20211029112407.2004234-1-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <77930ac8-7e67-85ed-9d06-39eb4172fba7@...2507...>
Date: Fri, 29 Oct 2021 15:25:24 +0200
MIME-Version: 1.0
In-Reply-To: <20211029112407.2004234-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4] Add insecure tls-cert-profile options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 29/10/2021 13:24, Arne Schwabe wrote:
> The recent deprecation of SHA1 certificates in OpenSSL 3.0 makes it necessary
> to reallow them in certain deployments. Currently this works by using the
> hack of using tls-cipher "DEFAULT:@SECLEVEL=0". Add insecure as option to
> tls-cert-profile to allow setting a seclevel of 0.
> 
> Patch v4: fix default accidentially changed to insecure
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

With OpenSSL 3, OpenVPN accepts certs signed with SHA1 if and only if
"--tls-cert-profile insecure" is used.

