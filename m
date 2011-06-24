From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 15:37:46 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B901266EBE82F@...1436...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/28] Refactor OpenSSL crypto functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

As a quick bootnote: the numbering of these patches starts at 10, continuin=
g from the previous doxygen patches...

Adriaan

> -----Original Message-----
> From: Adriaan de Jong [mailto:dejong@...1435...]
> Sent: vrijdag 24 juni 2011 11:55
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] [PATCH 0/28] Refactor OpenSSL crypto functions
>=20
> Hi everyone,
>=20
> This is the second series of patches for the master branch.
>=20
> This patch separates the OpenSSL crypto functions (those in crypto.c)
> into a separate OpenSSL backend. The API for this backend is defined in
> crypto_backend.h.
>=20
> Note that I also migrated all functions within OpenVPN that use crypto
> primitives, for compatibility with other SSL backends. The exception
> here is the functions in ssl.c, since they will be migrated in the next
> series of patches.
>=20
> Enjoy!
>=20
> Regards,
> Adriaan de Jong
>=20
>=20
> -----------------------------------------------------------------------
> -------
> All the data continuously generated in your IT infrastructure contains
> a
> definitive record of customers, application performance, security
> threats, fraudulent activity and more. Splunk takes this data and makes
> sense of it. Business sense. IT sense. Common sense..
> http://p.sf.net/sfu/splunk-d2d-c1
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

