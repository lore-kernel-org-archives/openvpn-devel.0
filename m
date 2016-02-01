Message-ID: <6A88A2ADF6B64829BF9DA9EAA97BF3B0@...2089...>
From: <debbie10t@...277...>
Date: Mon, 1 Feb 2016 23:01:58 -0000
MIME-Version: 1.0
Subject: [Openvpn-devel] Just a thought - config hashing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

I sat in on the meeting today 2016-02-01 as manhaton

Watching the discussion about elevated privileges regarding 
a non-admin user interacting with the iservice, a subject to which 
I am ignorant with regard to programming ..

Anyway, an idea struck me ...

It is a *little* off-piste so .. new thread.

Why not .. (pleaze shoot me down if this is stupid)

OpenVPN could HASH the *current* config file on the fly:

As the Client:
--verify-config-file ALG
ALG = algorithm 
The result of which is stored within openvpn variable(s)
IV_CONF_ALG = algorithm
IV_CONF_HASH = result
and pushed to the server with other IV_* variables.

As the Server this is down to the admin to configure:
--verify-config-file ALG FILE ([0/1])
ALG = algorithm
FILE = a file containing expected HASH value(s)
(Could be a third option [0/1] to include server HASH)

if the value is matched the config passes etc.
All connecting clients which do not provide suitable HASH
are disconnected .. probably with SIGTERM->client.
+ If --verify-config-file is used in the server config
+ Could also verify IV_CONF_ALG with server env

*Maybe* hand-off the file searching to a script on the server 
Not sure how effectively that could be done on windows ..
perhaps a plugin ?

Anyway, It looks ok to me but what do I know ?

Just a thought .. something for the wishlist ?
Thanks


