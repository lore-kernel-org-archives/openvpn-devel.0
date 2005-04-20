Message-ID: <1113995329.42663841c6501@...358...>
From: Bram <openvpn@...357...>
MIME-Version: 1.0
Subject: [Openvpn-devel] username-as-common-name: documentation error?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr 20 04:11:40 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,


What is the option --username-as-common-name supposed to do?

According to the manpage:

'For --auth-user-pass-verify authentication, use the authenticated username as
the common name, rather than the common name from the client cert'

I read this as: when the auth-user-pass-verify script is run the common name is
the same as the username, but when other scripts are run it has it's original
value.

Am I mis-interpreting this? or is it a documentation-error?

The openvpn howto seems to say something different:

'Such configurations should usually also set: username-as-common-name which will
tell the server to use the username for indexing purposes as it would use the
Common Name of a client which was authenticating via a client certificate.'

But then the question is what is considered as an indexing purpose?


It seems to me that after user/password authentication the username is used
everywhere where the common name would have been used (scripts, ccd, ...). Is
this assumption correct?



Regards,

Bram

