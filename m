Message-ID: <480915ca-a133-4941-bc4a-d193bcc3632a@...1800...>
Date: Fri, 29 Sep 2023 08:49:45 -0400
MIME-Version: 1.0
Content-Language: en-US
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
 <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
 <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
 <CAKuzo_j3BEfQGOSi9rYDMamFg5G+_7CninqNwQ9-J4jk52NPLA@...278...>
From: mike tancsa <mike@...1800...>
In-Reply-To: <CAKuzo_j3BEfQGOSi9rYDMamFg5G+_7CninqNwQ9-J4jk52NPLA@...278...>
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 9/28/2023 9:55 PM, Selva Nair wrote:
> Hi Mike
>
> I misunderstood Arne's comment. We default to security level 1 but 
> that forbids SHA1 signatures in OpenSSL 3.0+.
>
> Could you test with "tls-cert-profile Insecure" in the config file? 
> It's not recommended but useful to check.

Thanks! That allows it to connect

     ---Mike


