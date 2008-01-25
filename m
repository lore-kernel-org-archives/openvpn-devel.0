Date: Fri, 25 Jan 2008 11:00:22 -0600
From: Steven Pritchard <steve@...609...>
Message-ID: <20080125170022.GA23938@...611...>
References: <4797B53E.4020007@...41...>
MIME-Version: 1.0
In-Reply-To: <4797B53E.4020007@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net

Trying to build the Fedora package for rc6, I'm getting an error from
%check, which basically does this:

  ./openvpn --config sample-config-files/loopback-client &
  ./openvpn --config sample-config-files/loopback-server
  wait

I'm getting the following error:

  Thu Jan 24 14:15:33 2008 /sbin/ip addr flush dev null
  Device "null" does not exist.
  Thu Jan 24 14:15:33 2008 Linux ip flush failed: shell command exited with error status: 255

Full build log here:

  http://koji.fedoraproject.org/koji/getfile?taskID=370966&name=build.log

Steve
-- 
Steven Pritchard - K&S Pritchard Enterprises, Inc.
Email: steve@...610...             http://www.kspei.com/
Phone: (618)624-4440               Mobile: (618)567-7320

