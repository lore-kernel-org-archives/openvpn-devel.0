Message-ID: <559102CE.6030008@...1147...>
Date: Mon, 29 Jun 2015 10:33:18 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] minor man page issue
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

hi all,

whilst working on the --verify-client-cert patch I just noticed this in 
the man page:

--compat-names [no-remapping] (DEPRECATED)

[....]
               Please  note: This option is immediately deprecated. It 
is only implemented to make the tran-
               sition to the new formatting less intrusive.  It will be 
removed either  in  OpenVPN  v2.4  or
               v2.5.   So  please  make sure you use the 
--verify-x509-name option instead of --tls-remote as
               soon as possible and update your scripts where necessary.


I read it three times and still can't figure out why the disclaimer 
about --verify-x509-name instead of --tls-remote is included in this 
option.  Is this a copy+paste error?

JJK


