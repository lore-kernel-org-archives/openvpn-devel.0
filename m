MIME-Version: 1.0
In-Reply-To: <CAEsd45RxJ4Q6kvofngZwkEUBbV3P3fNWTEMc9KksKPOdpB870Q@...278...>
References: <CAEsd45RxJ4Q6kvofngZwkEUBbV3P3fNWTEMc9KksKPOdpB870Q@...278...>
Date: Sat, 7 Jul 2012 17:31:07 +0300
Message-ID: <CAOazyz3AqvSu05xSDQn=0MX-4QV-mFB1SPNh8SSVL_y3=O5R+g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 3.3_alpha2 build problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

Were does the lzo libraries and includes located?
If these are not located at default search path of your compiler you
should probably add: CFLAGS="-I<location>" LDFLAGS="-L<location>" to
configure.

Alon.

On Sat, Jul 7, 2012 at 5:21 PM, Jonathan K. Bullard <jkbullard@...277...> wrote:
> I'm trying to include OpenVPN 3.3_alpha2 in Tunnelblick (OS X GUI for
> OpenVPN), but get the following error when compiling OpenVPN on OS X:
>
>> configure: error: lzo enabled but missing
>
>
> I am not familiar with the new OpenVPN build process, but I assume this is
> because it is trying to build lzo itself. However, lzo has already been
> built by the Tunnelblick build script (as have openssl and pkcs11-helper).
>
> How can I tell the build process that I don't want it to do this? And how
> can I do the same for openssl and pkcs11-helper?
>
> The complete OpenVPN build log is attached.
>
> The Tunnelblick build process makes PPC and Intel versions of lzo, openssl,
> pkcs11-helper, and OpenVPN. Then it uses lipo to create a "Universal binary"
> for OS X that runs on PPC or Intel processors.
>
> Here's the script that builds OpenVPN (after building lzo, openssl, and
> pkcs11-helper separately).
>
>> for a in ppc i386; do \
>> cd openvpn/$$openvpndir/openvpn; \
>> $(MAKE) clean; \
>> autoreconf -i -v; \
>> CC=$(CC) CFLAGS="$(CFLAGS) -arch $$a" ./configure
>> --with-lzo-headers=../../../$(LZO_DIR)/staging/include
>> --with-lzo-lib=../../../$(LZO_DIR)/staging/lib
>> --with-pkcs11-helper-headers=../../../$(PKCS11_DIR)/staging/include
>> --with-pkcs11-helper-lib=../../../$(PKCS11_DIR)/staging/lib
>> --with-ssl-headers=$(OPENSSL_DEST_DIR)/include/$$a
>> --with-ssl-lib=$(OPENSSL_DEST_DIR)/lib --disable-dependency-tracking; \
>> $(MAKE) LIBS="$(OPENSSL_TARGET_FILES) -lpkcs11-helper -llzo2 -lz"; \
>> mv openvpn openvpn_tblk_$$a; \
>> cd ../../../; \
>> done; \
>> $(MAKE) -C openvpn/$$openvpndir/openvpn/plugin/down-root; \
>> lipo openvpn/$$openvpndir/openvpn/openvpn_tblk_* -create -output
>> openvpn/$$openvpndir/openvpn/openvpn; \
>
>
> (Note: the "cd openvpn/$$openvpndir/openvpn;" changes to the folder that
> contains the OpenVPN source. Tunnelblick typically includes binaries of two
> or three versions of OpenVPN, to facilitate testing.)
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

