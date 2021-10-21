References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-13-arne@...1227...>
 <CAKuzo_h6zwNySb7iu=bFGduxH7jB2OT_2TopZ0gYdYPmpRTO=g@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5554b1a1-02ec-a0af-c045-58aa999ed66f@...1227...>
Date: Thu, 21 Oct 2021 14:52:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h6zwNySb7iu=bFGduxH7jB2OT_2TopZ0gYdYPmpRTO=g@...278...>
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
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 20.10.21 um 20:19 schrieb Selva Nair:
> Hi,
> 
> Not a code review but a general comment as this is a new option that
> warrants some discussion.
> 
> On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
> 
>     This allows OpenVPN to load non-default providers. This is mainly
>     useful for loading the legacy provider with --provider legacy:default
> 
> 
> While this format looks okay, we need to consider a few things to get
> this option right and possibly extensible in future without causing a
> regression.
> 
> (i) Provider name may not be a simple word like legacy -- could also be
> the path to a shared object with possible embedded space in the path
> name. A single option with optional quotes, picked apart using ":" as
> separator can still work.
> 
> Ideally I would have preferred space separated provider names with
> each quoted if needed, but the format proposed here may be easier to
> parse. Need clear documentation, though.


Yeah using : was easier to parse since I need otherwise to setup an
array or a list to store the parameter but it is doable. I was just
hoping that nobody would use a : in the provider name.


> (ii) We may want to attach some meaning to the order in which providers
> are specified. 

That would be mostly a documentation thing to explain that the providers
are loaded the in order specified with that option.

Here is why:
> 
> When multiple providers implement the same method (say, KEYEXCH), there
> is no guarantee in OpenSSL as to which will get used. Unless a property
> query like "?provider=my-fast-aes" is also used. Here the prefix "?" to
> mean preferred but not exclusive. In cases like an pkcs11 token
> provider, one would need to say the opposite like "?provider=default" to
> ensure default is preferred and the token provider is to be used only
> when required -- say when the key is in a token. Same would be the case
> with our proposed built-in  "external-key provider" which should be used
> only for certain operations that handle the external key.
> 
> How this relates to the --provider option is like this: in some cases we
> want to know which provider the user prefers. Instead of hard-coding the
> preferred provider to "default" which the user may not even want to
> load. We could state that the first provider specified will become the
> preferred one when there are multiple choices for a method or when a
> preferred fallback is required. In that case the option for legacy would be
> 
> --provider default:legacy
> 
> And, if this option is absent, we take it to mean that the "default"
> provider should be loaded.

I would not explicitly load the default provider then but rather inherit
what the system gives us. If the system wide config loads fips we should
not load default instead.

> This explicit loading of providers takes away
> some ambiguity regarding which one's are made available. However, this
> could conflict with what is in the OpenSSL config file. Which is not a
> bad thing as we probably should not use the config file to load
> providers (which we currently do) -- it's not supported on some
> platforms (Windows as of now) and can lead to broken setups due to user
> error.

Yeah. I agree on that. I needed this for ANdroid where I also don't have
a OpenSSL and adding one is not something I really want to do.

> At the same time, provider paths and their names could be set up in
> OpenSSL config files, so loading them through config has some
> advantages. So, an alternate option is to not add this option at all and
> require the use of a config file to load additional providers like
> "legacy + default". Loading a custom config file is possible with
> OpenSSL 3.0 and could be enabled on Windows in a safe manner.  
> 
> Or always load providers from OPENSSL config and use the "--provider
> foo" on top of that.
> 
> We could also consider a separate option to specify a preferred property
> query ("?provider=myprov") that could be added later and not rely on any
> ordering here.
> 
> The above is just meant for further discussion -- I'm not entirely sure
> what the best approach is.

No, me neither.

Arne

