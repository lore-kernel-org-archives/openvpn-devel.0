MIME-Version: 1.0
References: <20210505051833.11271-1-selva.nair@...277...>
 <e3fedd37-6a74-50f5-f314-0ced6f1eba04@...1147...>
 <CAKuzo_iDFqz=a-vzM3d2T+YugdtBKb+S3UP1EfXRygrxajo=+g@...278...>
 <13180099-6739-83a5-ed3d-5811d1f658cf@...1147...>
In-Reply-To: <13180099-6739-83a5-ed3d-5811d1f658cf@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 6 May 2021 11:37:37 -0400
Message-ID: <CAKuzo_hkiAua=30HSaskds1MfvC3q09ttTt0HFvc=RNMWKHTUQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Allow PKCS#11 uri to be used as --cert
 and --key file names
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, May 6, 2021 at 6:12 AM Jan Just Keijser <janjust@...1147...> wrote:
>
> Hi Selva,
> > Maybe I'll have to resurrect that idea or require --script-security 2
> > for this? In either case the core code will stay the same -- will wait
> > for a review and/or more comments before changing anything.
> >
> wouldn't it make more sense to use the (existing) "--engine" parameter
> for this?   this is closely related to OpenSSL engines (even though the
> pkcs11 module is not loaded directly) .

The existing engine option supports only one engine and would need to
be extended and also require some non-trivial changes for this use
case. But taking your cue, it would be easier and cleaner to introduce
a new --use-pkcs11-engine option to specify the engine and module and
keep the file uri as pure pkcs11. Like:

--use-pkcs11-engine [engine_id] [module_path]

where the optional engine_id could be just an id if installed in a
location where OpenSSL can load from, else a full path. module_path
also could be relative or absolute as required.

> That way it will be fairly easy for tools like NetworkManager-openvpn to
> filter out any unwanted stuff.

>
> Also, another option would be to allow the loading of a pkcs11 module
> but *only* from predefined locations (e.g. /usr/lib or /usr/lib64) .
> This predefined location would then need to be configured at compile time.

That could work though quite limiting especially on Windows. On
unix-clones, one could just require engines and modules to be in
standard path and strip the so-path to its basename before use.

I would prefer the --pkcs11-engine option. We anyway have a million
options, one more is a drop in the bucket :)

Selva

