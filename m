Message-ID: <20031216214909.22770.qmail@...143...>
From: gary ng <garyng2000@...109...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Some product suggestions
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
Date: Tue Dec 16 13:50:01 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I have been testing using openvpn on Windows XP as
both a client and a server and found the following
issues:

If I started the openvpn service(say as a server
waiting for connections), I can no longer launch any
more 'client' in the forground(giving me some accessed
denied error in the netcmd). I believe this would be a
frequently used feature that is have a port open so if
anyone want to have a secured tunnel between their
machine and mine, they can initiate the connection. At
the same time, I want to do adhoc connection as a
client as well.

Talking about adhoc client, it is nice that openvpn
have some file association(say start .ovpn when I
double click). I envision a usage where I can use
https to goto a web login front end which would
generate the necessary .ovpn config file which once
download can be run automatically. This would simplify
the setup of openvpn further(just need to have the
program/tap driver installed). However, the key at the
moment needs to be pointed to a local file. If it can
be 'embedded' in the .ovpn file, the above usage would
be close to seamless. On the server side(assuming it
is linux), some script can also be written to start
instance of openvpn on the fly, connecting to the
apache process. This change should be relatively
easy(embedding the key) without an overhaul of the
existing one UDP port per tunnel structure but still
can let users to customize its usage(on the server
side) without going to each client workstation and do
the installation/configuration there.

any comments/critics are welcomed.

regards,

gary
PS. I am not on this list so please cc if possible.


__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/

