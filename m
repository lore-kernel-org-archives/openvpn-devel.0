Message-ID: <4B30D01B.6010709@...1114...>
Date: Tue, 22 Dec 2009 14:56:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC] Usage of bool in the source code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Yesterday evening I upgraded OpenVPN on a Gentoo box to the 2.1.0
release.  I'm also using the eurephia patch, so this was enabled as
well.  But then I discovered a few things which made things behave
badly, caused by probably a good intentioned patch.

The extra Gentoo patch basically removes the bool definitions in basic.h
and replaces it with including stdbool.h.

Now initially this can sound sensible, until you reach code pieces like
this:

#define SA_IP_PORT        (1<<0)
#define SA_SET_IF_NONZERO (1<<1)

...
/* set environmental variables for ip/port in *addr */
void
setenv_sockaddr (struct env_set *es, const char *name_prefix, const
                 struct openvpn_sockaddr *addr, const bool flags)
{
  char name_buf[256];

  if (flags & SA_IP_PORT)
    openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip", name_prefix);
  else
    openvpn_snprintf (name_buf, sizeof (name_buf), "%s", name_prefix);
...

What happened in my case was that the environment variables named
ifconfig_pool_remote_ip and ifconfig_pool_remote_netmask got an extra
_ip extension ... they became ifconfig_pool_remote_ip_ip and
ifconfig_pool_remote_netmask_ip.


** The core of problem **

The stdbool.h defined bool is not an int, which basic.h defines bool as.
 Meaning that bitwise operations on a bool (int) which works will not
work on the stdbool's bool type.

This makes me think once again ... bitwise operations on a bool?  Isn't
bool supposed to be 1 bit only?  Making bitwise operations rather
pointless?  And why using the bool type in a place where you need
bitwise flags?

I have reported this faulty patch to Gentoo, hoping they will remove it
soon.  But it still makes me wonder, if OpenVPN should use something
else than bool in these flag situations.


** A solution **

I'm suggesting to implement a new typedef, flag_t, which can be used in
these cases.  I'm suggesting:

        typedef uint32_t flag_t;

uint32_t is defined in stdint.h.

Then we would move over all places where bool is used as flags over to
the flag_t.  Why not just use uint32_t (or another int) directly?  To
make it more obvious that we are using the assigned variables as flags,
where bitwise operations will most likely occur.  This avoiding such
code confusion as I've just found.  Boolean types per definitions is
supposed to be treated as only 1 or 0, not a type you can do bitwise
operations on.


I've began doing some code review in regards to the usage of the bool
types.  This is to spot if such a usage is sensible or not, and to see
if this "misuse" of bool is happening somewhere else as well.  If this
is considered waste of time, please stop me NOW!  It's a rather
comprehensive job.  Booleans are used many places, and I check how each
single place is using this type, including functions returning bool to
each variable being defined as bool.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksw0BgACgkQDC186MBRfrpFcACeLlyMYGlh38YhUg+oIqwpssmw
nakAn1eonfAbTGW9WP1DZVzqtq/8YsvI
=Zsl1
-----END PGP SIGNATURE-----

