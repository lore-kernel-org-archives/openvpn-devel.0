References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-13-arne@...1227...>
 <CAKuzo_h6zwNySb7iu=bFGduxH7jB2OT_2TopZ0gYdYPmpRTO=g@...278...>
 <5554b1a1-02ec-a0af-c045-58aa999ed66f@...1227...>
 <CAKuzo_i+eN4Juj70S3v25wHwJepW69MGPEONHN=D1pQbSBK7PA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5aaca5a3-2087-6e1c-2284-5919111456a8@...1227...>
Date: Fri, 22 Oct 2021 16:57:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i+eN4Juj70S3v25wHwJepW69MGPEONHN=D1pQbSBK7PA@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 12/21] [OSSL 3.0] Allow loading of
 non default providers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> 
> IMO, this idea that OpenSSL folks have that just adding a "fips=yes"
> plus a few lines in the config can make the application FIPS enabled is
> far-fetched. In reality OpenVPN will have to be recompiled with some
> changes to make it FIPS compliant. At that point one can also change
> what providers are loaded by default.

There is a wide range between completely fully FIPS compliant and
non-FIPS compliant. Especially on Red Hat Enterprise, you can set the
system to a FIPS mode where OpenSSL stops offering non FIPS algorithms
and also other crypto libraries do not do non-FIPS algorithms anymore.

And I put some effort into making OpenVPN still behave nicely in those
situations. It is not really compliant/certified per se but for a lot of
customers that is "good enough".

The "fips=yes" is similiar I think. It is "good enough" for many people.

> I was thinking of having a load_providers() function called early -- say
> in options-post-process stage where we load

This commit already loads them as early as possible after parsing
options if the option is enabled.

> 
> (i) default provider
> (ii) providers specified in --providers option
> 
> This adds much certainty to what is available. A FIPS-enabled OpenVPN
> can change this or we could have a --fips option that changes this. No
> dependency on system-wide config file and those who need legacy only
> need to just specify "--providers legacy"
> 
> In addition, one could automatically load "legacy" if any of the options
> indicate its need -- like NTLM auth for proxy or BF-CBC in
> --data-ciphers etc. In situations where it cannot be inferred from
> options, user will have to use --providers legacy, though.
> 
> It may be necessary to call this load_providers() also to process
> options like --show-ciphers and similar.

No. I am actually against loading legacy on demand or loading the
default provider if --provider is not specified. Often there are system
wide security defaults in place and I don't think OpenVPN should
override them unless explicitly instructed to do so.

Especially in the Red Hat Enterprise 9 or whatever will have OpenSSL 3.0
I would expect in fips mode to switch to a global config of OpenSSL that
uses the FIPS provider instead of default. And I don't want to break
that by loading default.

Arne

