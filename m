Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170823053054.29982-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
Date: Wed, 6 Sep 2017 22:45:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170823053054.29982-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kXPxEkWaSJT0OEaduDt4fpsw8uDgcpMOW"
Subject: Re: [Openvpn-devel] [PATCH] route: cleanup codestyle and make code
 more readable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kXPxEkWaSJT0OEaduDt4fpsw8uDgcpMOW
Content-Type: multipart/mixed; boundary="1gFAuH3xABfIHTBrr6RF3mDbHpIIVHmTp";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <177bfb02-652a-abf6-4474-9a6575b14de4@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] route: cleanup codestyle and make code
 more readable
References: <20170823053054.29982-1-a@...2181...>
In-Reply-To: <20170823053054.29982-1-a@...2181...>

--1gFAuH3xABfIHTBrr6RF3mDbHpIIVHmTp
Content-Type: multipart/mixed;
 boundary="------------77FBF00E70BF504B6175EE3F"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------77FBF00E70BF504B6175EE3F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 23/08/17 07:30, Antonio Quartulli wrote:
> This patch does not introduce any functional change.
>=20
> The code in route.c seems to have been written in different
> periods by different people, without sticking to a clear
> codestyle. For this reason the code in this file in not
> consistent at all.
>=20
> Clean it up by:
> - removing spaces from function invocations
> - cutting line longer than 80 chars (where possible)
> - moving function arguments on the same line when there is enough space
> - adding empty line between var declarations and code
> - adding empty line between code and final return
> - adding empty line to make the code less sticky and easier to parse
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> Yes, this is a quite big patch. However, since we are planning  a big
> restructuring of the route.c file, it is better to take care of the
> style in a separate patch (this) so that later we don't need to mixup cle=
anups
> and refactoring.
>=20
> Note that this patch is based on master plus the following patches:
>=20
> - ensure function declarations are compiled with their definitions
> - fix a couple of typ0s in comments and strings
> - route: avoid definition of unused variables in certain configurations
> - convert *_inline attributes to bool
> - reformatting: fix style in crypto*.{c, h}
> - Allow learning iroutes with network made up of all 0s (only if netbits =
< 8)
> - ifconfig-ipv6(-push): allow using hostnames
>=20
>=20
> Applying this patch without the above, might lead to screams,
> natural disasters and endless nightmares.

I got it applying quite nicely (working my way through more patches
now).  And yes, I like that we clean up the coding style further in this
file.  But unfortunately, I'll have to say NAK in this round.

- Many places you replace spaces with tabs.
- There are several scenarios where our uncrustify config actually
  improves your patch further (see the attachment).
- And the contradictions like the ones below

> -static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, =
unsigned int flags, const struct route_gateway_info *rgi, const struct env_=
set *es);
> +static void delete_route(struct route_ipv4 *r, const struct tuntap *tt,
> +			 unsigned int flags,
> +			 const struct route_gateway_info *rgi,
> +			 const struct env_set *es);

vs

>  static void
> -delete_route(struct route_ipv4 *r,
> -             const struct tuntap *tt,
> -             unsigned int flags,
> -             const struct route_gateway_info *rgi,
> -             const struct env_set *es)
> +delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int=
 flags,
> +             const struct route_gateway_info *rgi, const struct env_set =
*es)

I think the change you do in the former one is also more readable than
squeezing everything into as few lines as possible, especially when
there's lots of arguments.

Our uncrustify config doesn't touch these details of function
declarations, as tun.c and route.c is fairly extreme in variations here.
 So we let that pass on the reformatting patch before the v2.4 release,
to take care of them manually, as we didn't spend much extra time
looking at more tweaks for uncrustify to make the result readable.  But
I'm not sure we documented our preferences on function declarations, I
don't recall that now.

Even though we are not united in the use of uncrustify after the
reformatting patches we did in December, I think it makes sense to at
least double check what uncrustify would change and consider those.  The
lesser the gap is to that result, the easier it will be to have a
consistent coding style over the complete code base.

For reference, the uncrustify command line I used was:

   $ uncrustify -c dev-tools/uncrustify.conf \
                 --no-backup -l C -p debug.uncr \
                 src/openvpn/route.c

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--------------77FBF00E70BF504B6175EE3F
Content-Type: text/x-patch;
 name="uncrust-modifications.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="uncrust-modifications.patch"

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 605c367c..3ae75b1b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -57,20 +57,20 @@ static bool add_route_service(const struct route_ipv4=
 *, const struct tuntap *);
 static bool del_route_service(const struct route_ipv4 *, const struct tu=
ntap *);
=20
 static bool add_route_ipv6_service(const struct route_ipv6 *,
-				   const struct tuntap *);
+                                   const struct tuntap *);
=20
 static bool del_route_ipv6_service(const struct route_ipv6 *,
-				   const struct tuntap *);
+                                   const struct tuntap *);
=20
 #endif
=20
 static void delete_route(struct route_ipv4 *r, const struct tuntap *tt,
-			 unsigned int flags,
-			 const struct route_gateway_info *rgi,
-			 const struct env_set *es);
+                         unsigned int flags,
+                         const struct route_gateway_info *rgi,
+                         const struct env_set *es);
=20
 static void get_bypass_addresses(struct route_bypass *rb,
-				 const unsigned int flags);
+                                 const unsigned int flags);
=20
 #ifdef ENABLE_DEBUG
=20
@@ -154,7 +154,7 @@ clone_route_option_list(const struct route_option_lis=
t *src, struct gc_arena *a)
=20
 struct route_ipv6_option_list *
 clone_route_ipv6_option_list(const struct route_ipv6_option_list *src,
-			     struct gc_arena *a)
+                             struct gc_arena *a)
 {
     struct route_ipv6_option_list *ret;
=20
@@ -166,7 +166,7 @@ clone_route_ipv6_option_list(const struct route_ipv6_=
option_list *src,
=20
 void
 copy_route_option_list(struct route_option_list *dest,
-		       const struct route_option_list *src, struct gc_arena *a)
+                       const struct route_option_list *src, struct gc_ar=
ena *a)
 {
     *dest =3D *src;
     dest->gc =3D a;
@@ -216,7 +216,7 @@ is_route_parm_defined(const char *parm)
=20
 static void
 setenv_route_addr(struct env_set *es, const char *key, const in_addr_t a=
ddr,
-		  int i)
+                  int i)
 {
     struct gc_arena gc =3D gc_new();
     struct buffer name =3D alloc_buf_gc(256, &gc);
@@ -343,7 +343,7 @@ init_route(struct route_ipv4 *r, struct addrinfo **ne=
twork_list,
      * like gw. getaddrinfo is called to convert a a addrinfo struct */
=20
     if (get_special_addr(rl, ro->network, (in_addr_t *) &special.s_addr,=

-			 &status))
+                         &status))
     {
         special.s_addr =3D htonl(special.s_addr);
         ret =3D openvpn_getaddrinfo(0, inet_ntoa(special), NULL, 0, NULL=
,
@@ -353,7 +353,7 @@ init_route(struct route_ipv4 *r, struct addrinfo **ne=
twork_list,
     {
         ret =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SI=
GNAL,
                                   ro->network, NULL, 0, NULL, AF_INET,
-				  network_list);
+                                  network_list);
     }
=20
     status =3D (ret =3D=3D 0);
@@ -368,7 +368,7 @@ init_route(struct route_ipv4 *r, struct addrinfo **ne=
twork_list,
     if (is_route_parm_defined(ro->netmask))
     {
         r->netmask =3D getaddr(GETADDR_HOST_ORDER | GETADDR_WARN_ON_SIGN=
AL,
-			     ro->netmask, 0, &status, NULL);
+                             ro->netmask, 0, &status, NULL);
         if (!status)
         {
             goto fail;
@@ -385,9 +385,9 @@ init_route(struct route_ipv4 *r, struct addrinfo **ne=
twork_list,
     {
         if (!get_special_addr(rl, ro->gateway, &r->gateway, &status))
         {
-            r->gateway =3D getaddr(GETADDR_RESOLVE | GETADDR_HOST_ORDER =
|
-				 GETADDR_WARN_ON_SIGNAL, ro->gateway, 0,
-				 &status, NULL);
+            r->gateway =3D getaddr(GETADDR_RESOLVE | GETADDR_HOST_ORDER
+                                 |GETADDR_WARN_ON_SIGNAL, ro->gateway, 0=
,
+                                 &status, NULL);
         }
         if (!status)
         {
@@ -456,7 +456,7 @@ init_route_ipv6(struct route_ipv6 *r6,
         if (inet_pton(AF_INET6, r6o->gateway, &r6->gateway) !=3D 1)
         {
             msg(M_WARN, PACKAGE_NAME "ROUTE6: cannot parse gateway spec =
'%s'",
-		r6o->gateway );
+                r6o->gateway );
         }
     }
     else if (rl6->spec_flags & RTSA_REMOTE_ENDPOINT)
@@ -501,8 +501,8 @@ fail:
=20
 void
 add_route_to_option_list(struct route_option_list *l, const char *networ=
k,
-			 const char *netmask, const char *gateway,
-			 const char *metric)
+                         const char *netmask, const char *gateway,
+                         const char *metric)
 {
     struct route_option *ro;
     ALLOC_OBJ_GC(ro, struct route_option, l->gc);
@@ -517,8 +517,8 @@ add_route_to_option_list(struct route_option_list *l,=
 const char *network,
=20
 void
 add_route_ipv6_to_option_list(struct route_ipv6_option_list *l,
-			      const char *prefix, const char *gateway,
-			      const char *metric)
+                              const char *prefix, const char *gateway,
+                              const char *metric)
 {
     struct route_ipv6_option *ro;
=20
@@ -546,7 +546,7 @@ clear_route_ipv6_list(struct route_ipv6_list *rl6)
=20
 void
 route_list_add_vpn_gateway(struct route_list *rl, struct env_set *es,
-			   const in_addr_t addr)
+                           const in_addr_t addr)
 {
     ASSERT(rl);
     rl->spec.remote_endpoint =3D addr;
@@ -561,8 +561,8 @@ add_block_local_item(struct route_list *rl,
 {
     const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
=20
-    if (((rl->rgi.flags & rgi_needed) =3D=3D rgi_needed) &&
-	(rl->rgi.gateway.netmask < 0xFFFFFFFF))
+    if (((rl->rgi.flags & rgi_needed) =3D=3D rgi_needed)
+        && (rl->rgi.gateway.netmask < 0xFFFFFFFF))
     {
         struct route_ipv4 *r1, *r2;
         unsigned int l2;
@@ -591,10 +591,10 @@ add_block_local(struct route_list *rl)
 {
     const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
=20
-    if ((rl->flags & RG_BLOCK_LOCAL) &&
-	((rl->rgi.flags & rgi_needed) =3D=3D rgi_needed) &&
-	(rl->spec.flags & RTSA_REMOTE_ENDPOINT) &&
-	(rl->spec.remote_host_local !=3D TLA_LOCAL))
+    if ((rl->flags & RG_BLOCK_LOCAL)
+        && ((rl->rgi.flags & rgi_needed) =3D=3D rgi_needed)
+        && (rl->spec.flags & RTSA_REMOTE_ENDPOINT)
+        && (rl->spec.remote_host_local !=3D TLA_LOCAL))
     {
         size_t i;
=20
@@ -610,8 +610,8 @@ add_block_local(struct route_list *rl)
         for (i =3D 0; i < rl->rgi.n_addrs; ++i)
         {
             const struct route_gateway_address *gwa =3D &rl->rgi.addrs[i=
];
-	    in_addr_t net1 =3D rl->rgi.gateway.addr & rl->rgi.gateway.netmask;
-	    in_addr_t net2 =3D gwa->addr & gwa->netmask;
+            in_addr_t net1 =3D rl->rgi.gateway.addr & rl->rgi.gateway.ne=
tmask;
+            in_addr_t net2 =3D gwa->addr & gwa->netmask;
=20
             /* omit the add/subnet in &rl->rgi which we processed above =
*/
             if ((net1 !=3D net2) || (rl->rgi.gateway.netmask !=3D gwa->n=
etmask))
@@ -624,8 +624,8 @@ add_block_local(struct route_list *rl)
=20
 bool
 init_route_list(struct route_list *rl, const struct route_option_list *o=
pt,
-		const char *remote_endpoint, int default_metric,
-		in_addr_t remote_host, struct env_set *es)
+                const char *remote_endpoint, int default_metric,
+                in_addr_t remote_host, struct env_set *es)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D true;
@@ -667,10 +667,10 @@ init_route_list(struct route_list *rl, const struct=
 route_option_list *opt,
     if (is_route_parm_defined(remote_endpoint))
     {
         bool defined =3D false;
-        rl->spec.remote_endpoint =3D getaddr(GETADDR_RESOLVE |
-					   GETADDR_HOST_ORDER |
-					   GETADDR_WARN_ON_SIGNAL,
-					   remote_endpoint, 0, &defined, NULL);
+        rl->spec.remote_endpoint =3D getaddr(GETADDR_RESOLVE
+                                           |GETADDR_HOST_ORDER
+                                           |GETADDR_WARN_ON_SIGNAL,
+                                           remote_endpoint, 0, &defined,=
 NULL);
=20
         if (defined)
         {
@@ -711,12 +711,12 @@ init_route_list(struct route_list *rl, const struct=
 route_option_list *opt,
                 struct addrinfo *curele;
                 for (curele =3D netlist; curele; curele =3D curele->ai_n=
ext)
                 {
-		    struct sockaddr_in *ai_addr;
+                    struct sockaddr_in *ai_addr;
                     struct route_ipv4 *new;
=20
                     ALLOC_OBJ_GC(new, struct route_ipv4, &rl->gc);
                     *new =3D r;
-		    ai_addr =3D (struct sockaddr_in *)curele->ai_addr;
+                    ai_addr =3D (struct sockaddr_in *)curele->ai_addr;
                     new->network =3D ntohl(ai_addr->sin_addr.s_addr);
                     new->next =3D rl->routes;
                     rl->routes =3D new;
@@ -775,9 +775,9 @@ route_ipv6_match_host(const struct route_ipv6 *r6, co=
nst struct in6_addr *host)
=20
 bool
 init_route_ipv6_list(struct route_ipv6_list *rl6,
-		     const struct route_ipv6_option_list *opt6,
-		     const char *remote_endpoint, int default_metric,
-		     const struct in6_addr *remote_host_ipv6,
+                     const struct route_ipv6_option_list *opt6,
+                     const char *remote_endpoint, int default_metric,
+                     const struct in6_addr *remote_host_ipv6,
                      struct env_set *es)
 {
     struct gc_arena gc =3D gc_new();
@@ -807,7 +807,7 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     if (rl6->rgi6.flags & RGI_ADDR_DEFINED)
     {
         setenv_str(es, "net_gateway_ipv6",
-		   print_in6_addr(rl6->rgi6.gateway.addr_ipv6, 0, &gc));
+                   print_in6_addr(rl6->rgi6.gateway.addr_ipv6, 0, &gc));=

 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
@@ -820,14 +820,14 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     if (is_route_parm_defined(remote_endpoint))
     {
         if (inet_pton(AF_INET6, remote_endpoint,
-		      &rl6->remote_endpoint_ipv6) =3D=3D 1)
+                      &rl6->remote_endpoint_ipv6) =3D=3D 1)
         {
             rl6->spec_flags |=3D RTSA_REMOTE_ENDPOINT;
         }
         else
         {
             msg(M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve VP=
N endpoint: %s",
-		remote_endpoint);
+                remote_endpoint);
             ret =3D false;
         }
     }
@@ -859,8 +859,8 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
                  * avoiding routing loops, so ignore this part and let
                  * need_remote_ipv6_route always evaluate to false
                  */
-                if (remote_host_ipv6 &&
-		    route_ipv6_match_host(r6, remote_host_ipv6))
+                if (remote_host_ipv6
+                    && route_ipv6_match_host(r6, remote_host_ipv6))
                 {
                     need_remote_ipv6_route =3D true;
                     msg(D_ROUTE, "ROUTE6: %s/%d overlaps IPv6 remote %s,=
 adding host route to VPN endpoint",
@@ -875,7 +875,7 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     /* add VPN server host route if needed */
     if (need_remote_ipv6_route)
     {
-	int defined =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+        int defined =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
=20
         if ((rl6->rgi6.flags & defined) =3D=3D defined)
         {
@@ -912,8 +912,8 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
=20
 static void
 add_route3(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
-	   const struct tuntap *tt, unsigned int flags,
-	   const struct route_gateway_info *rgi, const struct env_set *es)
+           const struct tuntap *tt, unsigned int flags,
+           const struct route_gateway_info *rgi, const struct env_set *e=
s)
 {
     struct route_ipv4 r;
=20
@@ -927,8 +927,8 @@ add_route3(in_addr_t network, in_addr_t netmask, in_a=
ddr_t gateway,
=20
 static void
 del_route3(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
-	   const struct tuntap *tt, unsigned int flags,
-	   const struct route_gateway_info *rgi, const struct env_set *es)
+           const struct tuntap *tt, unsigned int flags,
+           const struct route_gateway_info *rgi, const struct env_set *e=
s)
 {
     struct route_ipv4 r;
=20
@@ -942,9 +942,9 @@ del_route3(in_addr_t network, in_addr_t netmask, in_a=
ddr_t gateway,
=20
 static void
 add_bypass_routes(struct route_bypass *rb, in_addr_t gateway,
-		  const struct tuntap *tt, unsigned int flags,
+                  const struct tuntap *tt, unsigned int flags,
                   const struct route_gateway_info *rgi,
-		  const struct env_set *es)
+                  const struct env_set *es)
 {
     int i;
=20
@@ -953,16 +953,16 @@ add_bypass_routes(struct route_bypass *rb, in_addr_=
t gateway,
         if (rb->bypass[i])
         {
             add_route3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, tt,
-		       flags | ROUTE_REF_GW, rgi, es);
+                       flags | ROUTE_REF_GW, rgi, es);
         }
     }
 }
=20
 static void
 del_bypass_routes(struct route_bypass *rb, in_addr_t gateway,
-		  const struct tuntap *tt, unsigned int flags,
-		  const struct route_gateway_info *rgi,
-		  const struct env_set *es)
+                  const struct tuntap *tt, unsigned int flags,
+                  const struct route_gateway_info *rgi,
+                  const struct env_set *es)
 {
     int i;
=20
@@ -971,14 +971,14 @@ del_bypass_routes(struct route_bypass *rb, in_addr_=
t gateway,
         if (rb->bypass[i])
         {
             del_route3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, tt,
-		       flags | ROUTE_REF_GW, rgi, es);
+                       flags | ROUTE_REF_GW, rgi, es);
         }
     }
 }
=20
 static void
 redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap=
 *tt,
-			      unsigned int flags, const struct env_set *es)
+                              unsigned int flags, const struct env_set *=
es)
 {
     const char err[] =3D "NOTE: unable to redirect default gateway --";
=20
@@ -986,22 +986,22 @@ redirect_default_route_to_vpn(struct route_list *rl=
, const struct tuntap *tt,
     {
         bool local =3D rl->flags & RG_LOCAL;
=20
-        if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT) &&
-	    (rl->flags & RG_REROUTE_GW))
+        if (!(rl->spec.flags & RTSA_REMOTE_ENDPOINT)
+            && (rl->flags & RG_REROUTE_GW))
         {
             msg(M_WARN, "%s VPN gateway parameter (--route-gateway or --=
ifconfig) is missing",
-		err);
+                err);
         }
         /*
          * check if a default route is defined, unless:
          * - we are connecting to a remote host in our network
          * - we are connecting to a non-IPv4 remote host (i.e. we use IP=
v6)
          */
-        else if (!(rl->rgi.flags & RGI_ADDR_DEFINED) && !local &&
-                 (rl->spec.remote_host !=3D IPV4_INVALID_ADDR))
+        else if (!(rl->rgi.flags & RGI_ADDR_DEFINED) && !local
+                 && (rl->spec.remote_host !=3D IPV4_INVALID_ADDR))
         {
             msg(M_WARN, "%s Cannot read current default gateway from sys=
tem",
-		err);
+                err);
         }
         else if (!(rl->spec.flags & RTSA_REMOTE_HOST))
         {
@@ -1033,7 +1033,7 @@ redirect_default_route_to_vpn(struct route_list *rl=
, const struct tuntap *tt,
                 if (rl->spec.remote_host !=3D IPV4_INVALID_ADDR)
                 {
                     add_route3(rl->spec.remote_host, IPV4_NETMASK_HOST,
-			       rl->rgi.gateway.addr, tt, flags | ROUTE_REF_GW,
+                               rl->rgi.gateway.addr, tt, flags | ROUTE_R=
EF_GW,
                                &rl->rgi, es);
                     rl->iflags |=3D RL_DID_LOCAL;
                 }
@@ -1046,7 +1046,7 @@ redirect_default_route_to_vpn(struct route_list *rl=
, const struct tuntap *tt,
=20
             /* route DHCP/DNS server traffic through original default ga=
teway */
             add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt=
, flags,
-			      &rl->rgi, es);
+                              &rl->rgi, es);
=20
             if (rl->flags & RG_REROUTE_GW)
             {
@@ -1471,11 +1471,11 @@ local_route(in_addr_t network, in_addr_t netmask,=
 in_addr_t gateway,
             const struct route_gateway_info *rgi)
 {
     /* set LR_MATCH on local host routes */
-    const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED |
-                            RGI_IFACE_DEFINED);
+    const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED
+                            |RGI_IFACE_DEFINED);
=20
-    if (rgi && ((rgi->flags & rgi_needed) =3D=3D rgi_needed) &&
-        (gateway =3D=3D rgi->gateway.addr) && (netmask =3D=3D 0xFFFFFFFF=
))
+    if (rgi && ((rgi->flags & rgi_needed) =3D=3D rgi_needed)
+        && (gateway =3D=3D rgi->gateway.addr) && (netmask =3D=3D 0xFFFFF=
FFF))
     {
         if (((network ^ rgi->gateway.addr) & rgi->gateway.netmask) =3D=3D=
 0)
         {
@@ -1508,8 +1508,8 @@ static inline bool
 is_on_link(const int is_local_route, const unsigned int flags,
            const struct route_gateway_info *rgi)
 {
-    return rgi && ((is_local_route =3D=3D LR_MATCH) ||
-                   ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)=
));
+    return rgi && ((is_local_route =3D=3D LR_MATCH)
+                   || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LI=
NK)));
 }
=20
 void
@@ -1857,16 +1857,16 @@ add_route_ipv6(struct route_ipv6 *r6, const struc=
t tuntap *tt,
     network =3D print_in6_addr(r6->network, 0, &gc);
     gateway =3D print_in6_addr(r6->gateway, 0, &gc);
=20
-#if defined(TARGET_DARWIN) ||  \
-    defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) ||  \
-    defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#if defined(TARGET_DARWIN)     \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)     \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
=20
     /* the BSD platforms cannot specify gateway and interface independen=
tly,
      * but for link-local destinations, we MUST specify the interface, s=
o
      * we build a combined "$gateway%$interface" gateway string
      */
-    if (r6->iface !=3D NULL && gateway_needed &&
-        IN6_IS_ADDR_LINKLOCAL(&r6->gateway))        /* fe80::...%intf */=

+    if (r6->iface !=3D NULL && gateway_needed
+        && IN6_IS_ADDR_LINKLOCAL(&r6->gateway))     /* fe80::...%intf */=

     {
         int len =3D strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp =3D gc_malloc( len, true, &gc );
@@ -1890,8 +1890,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct =
tuntap *tt,
      * interfaces.   OTOH, on "tap" interface, we must always set the
      * gateway unless the route is to be an on-link network
      */
-    if ((tt->type =3D=3D DEV_TYPE_TAP) &&
-        !((r6->flags & RT_METRIC_DEFINED) && (r6->metric =3D=3D 0)))
+    if ((tt->type =3D=3D DEV_TYPE_TAP)
+        && !((r6->flags & RT_METRIC_DEFINED) && (r6->metric =3D=3D 0)))
     {
         gateway_needed =3D true;
     }
@@ -2303,16 +2303,16 @@ delete_route_ipv6(const struct route_ipv6 *r6, co=
nst struct tuntap *tt,
     network =3D print_in6_addr(r6->network, 0, &gc);
     gateway =3D print_in6_addr(r6->gateway, 0, &gc);
=20
-#if defined(TARGET_DARWIN) ||    \
-    defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) ||   \
-    defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#if defined(TARGET_DARWIN)       \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)      \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
=20
     /* the BSD platforms cannot specify gateway and interface independen=
tly,
      * but for link-local destinations, we MUST specify the interface, s=
o
      * we build a combined "$gateway%$interface" gateway string
      */
-    if ((r6->iface !=3D NULL) && gateway_needed &&
-        IN6_IS_ADDR_LINKLOCAL(&r6->gateway))        /* fe80::...%intf */=

+    if ((r6->iface !=3D NULL) && gateway_needed
+        && IN6_IS_ADDR_LINKLOCAL(&r6->gateway))     /* fe80::...%intf */=

     {
         int len =3D strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp =3D gc_malloc(len, true, &gc);
@@ -2327,8 +2327,8 @@ delete_route_ipv6(const struct route_ipv6 *r6, cons=
t struct tuntap *tt,
     /* if we used a gateway on "add route", we also need to specify it o=
n
      * delete, otherwise some OSes will refuse to delete the route
      */
-    if ((tt->type =3D=3D DEV_TYPE_TAP) &&
-        !((r6->flags & RT_METRIC_DEFINED) && (r6->metric =3D=3D 0)))
+    if ((tt->type =3D=3D DEV_TYPE_TAP)
+        && !((r6->flags & RT_METRIC_DEFINED) && (r6->metric =3D=3D 0)))
     {
         gateway_needed =3D true;
     }
@@ -2597,8 +2597,8 @@ test_routes(const struct route_list *rl, const stru=
ct tuntap *tt)
                                   r->gateway);
             }
=20
-            if ((rl->flags & RG_ENABLE) &&
-                (rl->spec.flags & RTSA_REMOTE_ENDPOINT))
+            if ((rl->flags & RG_ENABLE)
+                && (rl->spec.flags & RTSA_REMOTE_ENDPOINT))
             {
                 test_route_helper(&ret, &count, &good, &ambig, adapters,=

                                   rl->spec.remote_endpoint);
@@ -2818,12 +2818,18 @@ add_route_ipapi(const struct route_ipv4 *r, const=
 struct tuntap *tt,
     DWORD if_index;
=20
     if (adapter_index =3D=3D TUN_ADAPTER_INDEX_INVALID)
+    {
         if_index =3D windows_route_find_if_index(r, tt);
+    }
     else
+    {
         if_index =3D adapter_index;
+    }
=20
     if (if_index =3D=3D TUN_ADAPTER_INDEX_INVALID)
+    {
         return false;
+    }
=20
     gc =3D gc_new();
     MIB_IPFORWARDROW fr;
@@ -2914,7 +2920,9 @@ del_route_ipapi(const struct route_ipv4 *r, const s=
truct tuntap *tt)
     const DWORD if_index =3D windows_route_find_if_index(r, tt);
=20
     if (if_index =3D=3D TUN_ADAPTER_INDEX_INVALID)
+    {
         return false;
+    }
=20
     gc =3D gc_new();
     MIB_IPFORWARDROW fr;
@@ -2953,8 +2961,8 @@ do_route_service(const bool add, const route_messag=
e_t *rt, const size_t size,
     ack_message_t ack;
     struct gc_arena gc =3D gc_new();
=20
-    if (!WriteFile(pipe, rt, size, &len, NULL) ||
-        !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
+    if (!WriteFile(pipe, rt, size, &len, NULL)
+        || !ReadFile(pipe, &ack, sizeof(ack), &len, NULL))
     {
         msg(M_WARN, "ROUTE: could not talk to service: %s [%lu]",
             strerror_win32(GetLastError(), &gc), GetLastError());
@@ -3040,8 +3048,8 @@ do_route_ipv6_service(const bool add, const struct =
route_ipv6 *r,
      * The tapdrvr knows about it and will answer neighbor discovery pac=
kets.
      * (only do this for routes actually using the tun/tap device)
      */
-    if ((tt->type =3D=3D DEV_TYPE_TUN) &&
-        (msg.iface.index =3D=3D tt->adapter_index))
+    if ((tt->type =3D=3D DEV_TYPE_TUN)
+        && (msg.iface.index =3D=3D tt->adapter_index))
     {
         inet_pton(AF_INET6, "fe80::8", &msg.gateway.ipv6);
     }
@@ -3232,7 +3240,9 @@ get_default_gateway(struct route_gateway_info *rgi)=

         for (ifr =3D ifc.ifc_req; ifr < ifend; ifr++)
         {
             if (ifr->ifr_addr.sa_family !=3D AF_INET)
+            {
                 continue;
+            }
=20
             /* get interface addr */
             struct sockaddr_in *sk_addr =3D (struct sockaddr_in *)&ifr->=
ifr_addr;
@@ -3254,22 +3264,22 @@ get_default_gateway(struct route_gateway_info *rg=
i)
             if (rgi->flags & RGI_ON_LINK)
             {
                 /* check that interface name of current interface
-                 * matches interface name of best default route */
+                * matches interface name of best default route */
                 if (strcmp(ifreq.ifr_name, best_name))
                 {
                     continue;
                 }
 #if 0
                 /* if point-to-point link, use remote addr as route gate=
way */
-                if ((ifreq.ifr_flags & IFF_POINTOPOINT) &&
-                    (ioctl(sd, SIOCGIFDSTADDR, &ifreq) >=3D 0))
+                if ((ifreq.ifr_flags & IFF_POINTOPOINT)
+                    && (ioctl(sd, SIOCGIFDSTADDR, &ifreq) >=3D 0))
                 {
                     rgi->gateway.addr =3D ntohl((addr->sin_addr.s_addr);=

-                    if (rgi->gateway.addr)
+                                              if (rgi->gateway.addr)
                     {
                         rgi->flags &=3D ~RGI_ON_LINK;
                     }
-                }
+                                              }
 #endif
             }
             else
@@ -3440,8 +3450,8 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_=
info *rgi6,
         /* we're only looking for routes in the main table, as "we have
          * no IPv6" will lead to a lookup result in "Local" (::/0 reject=
)
          */
-        if ((rtm->rtm_family !=3D AF_INET6) ||
-            (rtm->rtm_table !=3D RT_TABLE_MAIN))
+        if ((rtm->rtm_family !=3D AF_INET6)
+            || (rtm->rtm_table !=3D RT_TABLE_MAIN))
         {
             /* we're not interested */
             continue;
@@ -3495,9 +3505,9 @@ done:
     }
 }
=20
-#elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS) ||     \
-      defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) ||  \
-      defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+#elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS)        \
+    || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)     \
+    || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
=20
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -3726,7 +3736,7 @@ get_default_gateway(struct route_gateway_info *rgi)=

         close(sockfd);
         sockfd =3D -1;
=20
-        for (cp =3D buffer; cp <=3D (buffer + ifc.ifc_len - sizeof(struc=
t ifreq));)
+        for (cp =3D buffer; cp <=3D (buffer + ifc.ifc_len - sizeof(struc=
t ifreq)); )
         {
             ifr =3D (struct ifreq *)cp;
 #if defined(TARGET_SOLARIS)
@@ -3811,8 +3821,8 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_=
info *rgi6,
     so_dst.sin6_family =3D AF_INET6;
     so_mask.sin6_family =3D AF_INET6;
=20
-    if ((dest !=3D NULL) &&                /* specific host? */
-        !IN6_IS_ADDR_UNSPECIFIED(dest))
+    if ((dest !=3D NULL)                   /* specific host? */
+        && !IN6_IS_ADDR_UNSPECIFIED(dest))
     {
         so_dst.sin6_addr =3D *dest;
         /* :: needs /0 "netmask", host route wants "no netmask */
@@ -4032,8 +4042,8 @@ netmask_to_netbits2(in_addr_t netmask)
 static void
 add_host_route_if_nonlocal(struct route_bypass *rb, const in_addr_t addr=
)
 {
-    if ((test_local_addr(addr, NULL) =3D=3D TLA_NONLOCAL) &&
-        (addr !=3D 0) && (addr !=3D IPV4_NETMASK_HOST))
+    if ((test_local_addr(addr, NULL) =3D=3D TLA_NONLOCAL)
+        && (addr !=3D 0) && (addr !=3D IPV4_NETMASK_HOST))
     {
         add_bypass_address(rb, addr);
     }

--------------77FBF00E70BF504B6175EE3F--

--1gFAuH3xABfIHTBrr6RF3mDbHpIIVHmTp--

--kXPxEkWaSJT0OEaduDt4fpsw8uDgcpMOW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsF5qAAoJEIbPlEyWcf3yp5MQAMVWxTn6W3rqc/QJ2XoGIEni
qHrfpSNX5saoxWIcQiXt121CVU8E1qWZQ3FOeaZHzWF2YxRUWPgdlePX26Swv0XK
PY7wvd3p7BH1uF63a8V4I43fqnl5qOatldhRlgT56tBRp8OhkJ68xgpI8FcHgPa9
R1v57zB08+wSLIaAvUlWLd+cp0Eu9+aolBqFRis0JWBQnpuEhkRpLWlTz48tK5zZ
rz03/J22SuC83o/VZ/PAnCmoT5ovBg1raXkZdZebMb3hKtD00hx9nakoKsqEYXLh
f5s+QWIGeFHtHOxz0lqO9k/MEZGPy/V6XNcRQ8CzoBzc+XujTGRgf5GzZffEF2NC
2HKtb44H0+g1sl45UxxYZHahlif6p2UwrVYXkan3Lo9VOit8AuW5U+KZnfJUDUF8
iD+7x4nUFEITnjFwJJ2eGXmDV2XKubnfoz0RVynpKuyzevXLiaDWXBM9W7HxTJFj
9LDZMhMPhWpjPt/XPOb+gPMaZi4MDkkrEAlCpgAlDzC9L30FhBeYVhQyGl/74S1C
LC/A6W41pt3erpv9QY8CFfVv1NCkDHFGRHYvF+djYlOZP2z9DF52B5dVforsUxBB
uQAK2sT1CttNePDGKtGZShJ0rx+zXkWXFXj0kiEBKxtqKXrAGWC2SvoLggWvRmvN
m/hI5Ek4tcjEBp82LRl+
=s03s
-----END PGP SIGNATURE-----

--kXPxEkWaSJT0OEaduDt4fpsw8uDgcpMOW--

