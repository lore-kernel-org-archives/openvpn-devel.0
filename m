Message-ID: <d5b618ef-1611-3c65-586c-bc881bcf09ab@...1227...>
Date: Thu, 18 Aug 2022 09:51:45 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <6900ED88-65D7-450E-8A3A-3D9509D206AD@...2692...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <6900ED88-65D7-450E-8A3A-3D9509D206AD@...2692...>
Subject: Re: [Openvpn-devel] Possible bug?
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
To: Magnus Larsson <list@...2692...>, openvpn-devel@lists.sourceforge.net

Am 18.08.22 um 03:37 schrieb Magnus Larsson via Openvpn-devel:
> Hi,
> 
> I just moved from Ubuntu 20.04 LTS (where the exact command works fine 
> and does not prompt for pass phrase) to Red Hat Enterprise Linux 9 and 
> installed Easy-RSA via EPEL.

Probably old keys with now unsupported RC4 encryption in OpenSSL 3. You 
will have to make OpenSSL to load the legacy provider.

Arne

