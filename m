From: debbie10t <debbie10t@...277...>
Message-ID: <326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>
Date: Thu, 25 Aug 2016 16:17:25 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel]  2.3.12 vs git-master with cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

this is an odd one that i am only reporting as it feels like
something may have been over looked.


1.
Start off running win10 server openvpn git-master 20160818
with --cipher AES-256-CBC defined

Linux client running git:master/d1bd37fd508ee046
with --cipher AES-256-CBC defined

Client connects ok --cipher is negotiated up to AES-256-*GCM*
ie: Data Channel Encrypt: Cipher 'AES-256-GCM' initialized with 256 bit key

No problem.
===

2.a
Now leave the client running and stop the server
Uninstall openvpn on the server and then install 2.3.12-i601_x86-64
Restart the server.

Now server cannot negotiate --cipher and is set at AES-256-CBC
Connecting linux client cannot renegotiate --cipher and is set at 
AES-256-GCM
On --ping-restart --cipher is not reset and so the client can no longer 
connect.

Problem.
===

2.b
At the same time a winXP client is running openvpn 2.3.12-i001_i686
with --cipher AES-256-CBC defined

When this connects to the git:master server AES-256-CBC is honoured
as the client cannot negotiate

When the server is changed to 2.3.12 the winXP client *can* reconnect

No problem
===


I hazard a guess that --client --ping-restart does not reset --cipher.
but I do not know if that is intended ..

Regards


