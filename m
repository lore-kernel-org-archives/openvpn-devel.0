From: Jose Sanchez <jose.informatica@...1125...>
In-Reply-To: <48D4AD5B.10205@...1127...>
References: <1221820480.14052.2.camel@...1126...>
	<48D4AD5B.10205@...1127...>
Date: Mon, 22 Sep 2008 08:28:48 +0200
Message-Id: <1222064928.10967.17.camel@...1126...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] About making plugins for openvpn
Reply-To: jose.informatica@...1125...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Thank you, I have figured out those things (but not all of them, so
thanks for the detailed explanation).

The problem that I have is that I have not found good examples about the
structure of the environment variable (I have seen the: get_env function
in simple.c so I will try to print that variable to the log or to the
stdout to study its structure and data stored on it).

Thanks to all for the help. As a suggestion, I would upload a mini-howto
about making plugins at the website, description made by David Sommerset
in this email can be very helpful and if it was a wiki, all people could
collaborate.

Thanks again, I will tell you about my success or not about making the
plugin.

--=20
Jose S=C3=A1nchez <jose dot informatica at centrolamilagrosa dot org>


El s=C3=A1b, 20-09-2008 a las 09:59 +0200, David Sommerseth escribi=C3=B3:
>=20
> Jose Sanchez wrote:
> > Hello, I am new at openvpn, I am trying to do a very simple plugin to
> > see connections/disconnections and to be able to notify to another
> > system in "real" time.
> >=20
> > The problem is that I haven't found any documentation about the code or
> > about how to make plugins except on the code (I have been reading the
> > comments and I have some code of my plugin).
> >=20
> > The main problem is that there are two functions: OPENVPN_PLUGIN_DEF int
> > OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v1)
> >      (openvpn_plugin_handle_t handle, const int type, const char
> > *argv[], const char *envp[]);
> > and
> > OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v2)
> >      (openvpn_plugin_handle_t handle,
> >       const int type,
> >       const char *argv[],
> >       const char *envp[],
> >       void *per_client_context,
> >       struct openvpn_plugin_string_list **return_list);
> >=20
> > What I need is to obtain the public (inet IP) and the private (vpn ip)
> > when a client connects/disconnect to notify it to another program (I
> > know I can make a ping or similar things but it seems to be too slow
> > when there are a lot of clients connected (> 100)).
> >=20
> > What I need is to know in which variable is that data and which function
> > I need to implement (v1 or v2) and how these functions works (Is any
> > documentation on any site?).
> >=20
> > In openvpn_plugin_open_v1 I have registered the events: *type_mask =3D
> > OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT) |
> > OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT); and even on
> > openvpn_plugin_func_v1  I can know if there is if (type =3D=3D
> > OPENVPN_PLUGIN_CLIENT_CONNECT) or OPENVPN_PLUGIN_CLIENT_DISCONNECT but I
> > don't know how to recover IP information.
> >=20
> > If somebody could help me or saying me where the documentation is would
> > be great.
> >=20
> > Thanks in advance and excuse my english (I have written this too
> > quickly) and excuse me if what i am asking is answered on another place
> > that I haven't found.
> >=20
>=20
> Hi!
>=20
> I'm writing a plugin as well, and I have been through the same as you're =
facing now.  It's not hard
> or difficult at all, but it requires some testing before you figure out a=
ll the pieces.  Anyway,
> have a look on those plugins available in the plugin directory in the Ope=
nVPN source code and you
> might find some help here.  Here it is several different approaches.  I u=
sed auth-pam as a starting
> point for my project.  This is btw. using the v1 plugin interface.  I see=
 that a v2. version is
> available, but have not ported my project to this interface yet.
>=20
> But I'll give you a quick overview here now.  You basically need 3 OpenVP=
N based function in your
> plugin:
>=20
> OPENVPN_EXPORT openvpn_plugin_handle_t
> openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const=
 char *envp[])
>=20
> OPENVPN_EXPORT int
> openvpn_plugin_func_v1(openvpn_plugin_handle_t handle,
>                        const int type,
>                        const char *argv[], const char *envp[])
>=20
> OPENVPN_EXPORT void
> openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
>=20
>=20
> The first one initialises your plugin, you set a side a memory buffer for=
 you plugin data (which is
> not per connection based, afaik).  Here is also where you set the OPENVPN=
_PLUGIN_MASK ... f.ex.
>=20
> 	*type_mask =3D OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
>                     | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNEC=
T);
>=20
> You also return the pointer to your memory buffer from this function.
>=20
>=20
> The second one is the one which is called on every plugin event from Open=
VPN.  Here's where your
> plugin does it's main work.  The handle variable is the pointer to your m=
emory buffer with your
> plugin data.
>=20
> The third one cleans up after you plugin when OpenVPN shuts down.  Again,=
 handle points at your
> plugin data.
>=20
>=20
> >From here, it is pretty much straight forward for the rest of the plugin=
.  But have a look on the
> other plugins as well, as they give more ideas how to do things more adva=
nced, like using
> environment variables (where you'll find your IP addresses).
>=20
>=20
> I hope this could help you out.
>=20
>=20
>=20
> kind regards,
>=20
> David Sommerseth



