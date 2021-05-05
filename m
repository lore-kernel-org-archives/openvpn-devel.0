MIME-Version: 1.0
References: <20210505051833.11271-1-selva.nair@...277...>
 <e3fedd37-6a74-50f5-f314-0ced6f1eba04@...1147...>
In-Reply-To: <e3fedd37-6a74-50f5-f314-0ced6f1eba04@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 5 May 2021 09:29:11 -0400
Message-ID: <CAKuzo_iDFqz=a-vzM3d2T+YugdtBKb+S3UP1EfXRygrxajo=+g@...278...>
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

Hi JJK,

On Wed, May 5, 2021 at 4:00 AM Jan Just Keijser <janjust@...1147...> wrote:
>
> Hi Selva,
>
> On 05/05/21 07:18, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > If either --cert or --key is specified as a PKCS#11 uri, try to
> > load the certificate and key from any accessible PKCS#11 device.
> > This does not require linking with any pkcs11 library, but needs
> > pkcs11 engine to be available on the target machine.
> >
> > In its simplest form, just have
> >
> > --cert pkcs11:token=...;serial=... etc..
> >
> > Either do not specify --key, or use the same uri for --key.
> >
> > That's all what is required if pkcs11 engine is installed in the
> > right location and optionally set up to load any necessary provider
> > libraries (e.g., via openssl.cnf or via PKCS11_MODULE_PATH).
> >
> > If both cert and key are specified, the last entry takes precedence
> > and is used to locate both the certificate and key. Use of different
> > uri's for the cert and key are not supported -- at least not in
> > this version. Specifying --cert as a file and --key as a uri or
> > vice versa is treated as a usage error.
> >
> > If the engine cannot be automatically loaded or a custom engine object
> > has to be loaded, the engine name or shared libraryx may be embedded
> > in the PKCS#11 uri. The module shared object path also may be so
> > embedded. For example,
> >
> > pkcs11:token=..;serial=...;engine=pkcs11.so;provider=libsofthsm2.so
> >
> > will use engine with id=pkcs11 and load libsofthsm2.so.
> >
> > Full path to the libraries may be included as required. These extra,
> > optional attributes in the URI are stripped before presented to the
> > PKCS#11 subsystem. Do not include type=cert or type=private in the uri
> > as the same uri is used for both certificate and private key.
> >
> > Requires building with OpenSSL engine support although the pkcs11 or
> > a compatible engine and provider libraries are required only at
> > run time.
> Great patch, but I see one possible security issue upsream with the
> ability to specify the pkcs11 driver:
>
> Right now, Linux tools like NetworkManager-openvpn allow a non-root user
> to specify certain parameters, like cert, key etc in either a GUI or a
> config file.
> These tools will *all* need to be updated to take into account (or most
> likely : BLOCK) the use of
>    cert pkcs11: ....
> as otherwise a rogue user can specify a pkcs11 driver with a backdoor,
> which NetworkManager would then happily pass on to the openvpn which
> runs as root ....

I had first had --pkcs11-id  used for this but currently all pkcs11
related options are conditional on ENABLE_PKCS11 which depends on
pkcs11-helper. Allowing a subset of those options leads to messy
ifdefs which I didn't like.

Maybe I'll have to resurrect that idea or require --script-security 2
for this? In either case the core code will stay the same -- will wait
for a review and/or more comments before changing anything.


Selva

