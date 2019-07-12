References: <20190403225657.8003-1-rosenp@...277...>
 <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <f44b86bf-0258-294f-9fcb-ade6059464aa@...68...>
Date: Fri, 12 Jul 2019 18:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCHv2] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 14.06.19 um 12:38 schrieb Arne Schwabe:
>
>> -#ifndef ENABLE_SMALL
>> +# ifndef ENABLE_SMALL
> The space between # and ifndef looks wrong.

It's standard C. (Chapter 3.8 in the 1989/1990 standard, chapter 6.10 in
recent editions, I checked 1999 and 2017/2018, although worded in a
quite convoluted way) and I have yet to see a relevant C compiler that
would reject this.

The # is a token by itself can can be separated from the other
preprocessing tokens on the same line by space and horizontal-tab.



