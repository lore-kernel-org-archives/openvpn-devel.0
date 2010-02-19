Message-ID: <4B7E88AC.9030701@...515...>
Date: Fri, 19 Feb 2010 14:48:44 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030507090703070408060305"
Subject: [Openvpn-devel] Summary of the IRC meeting (18th Feb 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030507090703070408060305
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of last week's meeting. The initial feature
deprecation process is described in it, as well as here:

http://www.secure-computing.net/wiki/index.php/OpenVPN/Developer_documentat=
ion

As we all need to follow the process, please let if there are any
problems with it. There's definitely room for improvement and
clarifications.

Btw. what do you think about including the full IRC chatlog in these
emails? It would make it much easier to see exactly what was discussed.
After all, the summary is only my personal interpretation of the discussion.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------030507090703070408060305
Content-Type: text/plain;
 name="openvpn_irc_meeting_2010-02-18.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn_irc_meeting_2010-02-18.txt"

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 18th January 2010
Time: 19:00 UTC

Full log available here:

http://secure-computing.net/logs/%23%23openvpn-discussion.log

Next meeting on Thu 25th Feb 2010. Same place but different time (18:00 UTC)

SUMMARY

Discussed how to organize testing of the "testing" tree. Agreed that we need dedicated testers with known setups/configurations. 
For example, each tester would have a Wiki page built on a template, containing the OS (e.g. Debian Lenny, OpenBSD), features in use (e.g. IPv6), network topology etc. Agreed that we can expect these (dedicated) testers to always use the latest "testing" version to reduce variables to minimum.

Discussed LDAP authentication setup for the community site in some detail. The current plan is to have a central LDAP server handling user authentication and have a self-service user registration (e.g. with http://code.google.com/p/pwm) for users. This can be shared by all services provided by the community site server. Later the service can be extended to other community sites (e.g. OpenVPN e.V) securely using OpenVPN. The whole LDAP directory can even be replicated to these other sites to provide redundancy. An overview of this setup is currently available here:

 http://users.utu.fi/sjsepp/openvpn/Community_Authentication.dia
 http://users.utu.fi/sjsepp/openvpn/Community_Authentication.png (does not show 100% correctly)

Discussed the possibility of using OpenID instead of LDAP. Samuli agreed to take a better look at OpenID authentication support in various web applications we might use.

Discussed the "FQDN for routes should expand to all IPs" patch and more specifically this part:

 From getaddr() [socket.c:220 - r5371]:

  if (h->h_addr_list[1]) /* more than one address returned */
    {
      int n = 0;
      /* count address list */
      while (h->h_addr_list[n])
	++n;
      ASSERT (n >= 2);

      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d
			      addresses, choosing one by random",
		   hostname,
		   n);

      /* choose address randomly, for basic load-balancing capability */
      ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);
    }

Agreed that this randomization is not probably required in most scenarios and as such should be removed or deprecated. For more thorough discussion see the full chatlog.

Discussed removal of features from the code (e.g. above randomization code). On the other hand backwards compatibility was seen as important. On the other hand excessive use of #ifdef's or run-time configuration options will erode the code in the long run. It was agreed that a feature deprecation process is necessary to accommodate both users (who depend on certain features) and developers (who depend on understandable code). Decided to start with something like this to minimize end-user impact:

1. Ask users if they are depending on a feature considered for deprecation (e.g. using the openvpn-users mailing list)
   1.1. If users complain, discuss the issue and possible solutions with them
   1.2. If there are no complaints, proceed to 2

2. Add logging code to deprecated pieces of code that are thought to affect a lot of users. For example, make it output a warning to the logs (e.g. "WARNING: this feature is being deprecated and will be removed soon"). Keep the code enabled by default.
  2.1. If users complain now, discuss the issue and possible solutions with them
  2.2. If there are no complaints, proceed to 3

3. Make the feature disabled by default, but allow enabling it at compile-time (use #ifdef's).
  3.1. If users complain now, discuss the issue and possible solutions with them
  3.2. If there are no complaints, proceed to 4

4. Remove the feature entirely from the code
  4.1. If users complain now, discuss the issue and possible solutions with them
  4.2. If there are no complaints, proceed to 5

5. Finished. The feature was not really important to anyone and is not cluttering the code anymore.

Each feature could be kept around in "deprecated" mode in the first stable release, disabled but available in the second and  removed in the third release. This will give users plenty of time to reach, depending on the release cycle.

Also agreed that each feature deprecation / removal needs to be documented visibly in the release notes.

Cron2 acknowledged the Eurephia patch from dazo based on clarifications given by James.

Decided to move the meeting time one hour earlier (18:00 UTC).

--------------030507090703070408060305--

