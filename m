Message-ID: <ea66b3a6-e613-ee56-e1cf-0cf61f3d3fc3@...1227...>
Date: Sun, 15 Jan 2023 12:41:32 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <1ed0360c-37fb-408d-aa70-88c3f571428e@...68...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <1ed0360c-37fb-408d-aa70-88c3f571428e@...68...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
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
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

>> If you are okay with this, please reply to this mail and confirm that.
>> Otherwise we might be forced to remove and/or rewrite your code.
> 
> The GPL, in its spirit, was developed to empower users, not businesses.
> 
> So, after pondering for many hours about planned obsolescence, vendor
> respect for the community, and in the light that commercial needs for
> embedded uses can license the C++ reimplementation from OpenVPN Inc.:
> Please reconsider amending towards "GPL2+" or "GPL3+" instead of
> weakening the copyleft.
> 

OpenVPN Inc does not license the C++ implementation under anything else 
than AGPL3. And we are not actually weaking the copyleft of the GPLv2 
here. The problem is that the Apache2 already has some terms that the 
GPLv3 also has but the GPLv2 has not, so that makes it incompatible in 
letter but not in spirit.

Arne

