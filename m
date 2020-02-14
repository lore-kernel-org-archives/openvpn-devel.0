References: <CAGyAFMX0MMWHC3GTpfoP1VOvvenNkzdrpZj_5N5RMNa8LphGYw@...278...>
 <20200213135047.9020-1-arne@...1227...>
 <CAGyAFMWK6cHc-eiigxrp8cVj4Vyz5NN-59MOOr-zGr_s9-16Gw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <773f2dde-7331-3f5d-d807-a44489f3a0c1@...1227...>
Date: Fri, 14 Feb 2020 15:23:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMWK6cHc-eiigxrp8cVj4Vyz5NN-59MOOr-zGr_s9-16Gw@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2 2/5] Implement dynamic NCP negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 14.02.20 um 13:23 schrieb Lev Stipakov:
> Hi,
> 
> to 13. helmik. 2020 klo 15.51 Arne Schwabe (arne@...1227...
> <mailto:arne@...1227...>) kirjoitti:
>>
>> Our current NCP version is flawed in the way that it can only indicate
> support for
> 
> Built and tested on Ubuntu 18 and MSVC. Works as advertised.
> 
> Out of curiosity - you picked strsep because strtok which we have used
> so far
> relies on evil global state?

Yes, one of the calls in that functions actually calls a function that
uses strtok, so then everything blows up.

Arne

