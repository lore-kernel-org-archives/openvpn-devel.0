MIME-Version: 1.0
References: <dc5c81c1-7529-07a9-2e53-750fec37ed56@...1856...>
 <20200217120340.20995-1-arne@...1227...>
 <CAGyAFMWHY=TuhkmDTC0XNAtskmjufU6SFA-HrSs6np4Rvctvcg@...278...>
 <f6c1bf53-c8fd-c708-ac85-8b666da362ef@...1227...>
In-Reply-To: <f6c1bf53-c8fd-c708-ac85-8b666da362ef@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 26 Jun 2020 12:51:34 +0300
Message-ID: <CAGyAFMU3RC3om1E+u-pDFicgP+Dz2bU1DyMVOB7poOy3kcvqew@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Make compression asymmetric by
 default and add warnings
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Apologize for delay.

I tested with various combinations of flags and code works as expected.

Let's reword messages as you proposed:

> We reword the message a bit so that two messages are not that bad if both
> are shown:
>
> WARNING: Compression for receiving enabled, Compression
> has been used in the past to break encryption. Sent packet are not compress unless "allow-compression yes" is also set.

A small typo:

.. Sent packets are not compressed ...

>
>
> WARNING: Compression for sending and receiving enabled, Compression has
> been used in the past to break encryption. Allowing compression allows
> attacks that break encryption. Using '--allow-compression yes' is
> strongly discouraged for common usage. See --compress in the manual
> page for more information

Semi-acked-by: Lev-Stipakov <lstipakov@...277...>


-- 
-Lev

