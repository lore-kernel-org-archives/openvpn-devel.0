Date: Fri, 31 Jul 2015 11:54:18 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20150731095418.GK3164@...2050...>
References: <20150730233727.GW3676@...2049...>
	<CAGyAFMWagBfdJtNvX_sK9CGH-SvvxgsnVBX3xx1Z2Ym41hhaGw@...278...>
	<20150731092451.GD3164@...2050...>
	<20150731093206.GE3164@...2050...>
MIME-Version: 1.0
In-Reply-To: <20150731093206.GE3164@...2050...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Samuel Thibault, le Fri 31 Jul 2015 11:32:06 +0200, a =E9crit :
> # Allows the plugin to use auth control files if OpenVPN (>=3D 2.1 rc8) p=
rovides them.
> # default is false
> # useauthcontrolfile=3Dfalse
>=20
> Why is the default false??

And still... The main loop uses

   pthread_mutex_lock(context->getMutexSend());
   context->addNewUser(newuser);
   pthread_cond_signal( context->getCondSend( ));
   pthread_mutex_unlock (context->getMutexSend());
   return OPENVPN_PLUGIN_FUNC_DEFERRED;

to signal the auth thread that a new connection is being tried, and the
auth thread basically does

   pthread_mutex_lock(context->getMutexSend());
   while(1)
   {
     if (nobody_yet)
       pthread_cond_wait(context->getCondSend(),context->getMutexSend());
     ...
     Do auth
     ...
   }
   pthread_mutex_unlock(context->getMutexSend());

I.e. it keeps the MutexSend busy all along the authentication! So even
with deferred authentication, the main loop can not manage to grasp the
mutex until the auth thread has finished authenticating the previous
user...

Anyway, this is an issue in the plugin, I'll switch over to the plugin
mailing list.

Samuel

