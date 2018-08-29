From: Christian Ehrhardt <christian.ehrhardt@...1808...>
Date: Wed, 29 Aug 2018 16:27:13 +0200
Message-Id: <20180829142715.417-1-christian.ehrhardt@...1808...>
Subject: [Openvpn-devel] [PATCH 0/2] extend systemd service files for common
 use cases
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,
tracking down an Ubuntu bug I found what seemed to be a circular
dependency around https://community.openvpn.net/openvpn/ticket/918

Realizing that your process requires the patches sent to the list I
thought it might help to prep those.

I'd highly sak to consider the first change, the second I can understand
the need but had no real use case myself so far.
To be able to discuss and also accept/nack them individually I split the
changes.

Eventually I'd also want to sync the systemd service content in
https://github.com/OpenVPN/sbuild_wrapper to what is upstream. Therefore
I was wondering how devel for that repo is done. After the discussion here
resolves will a PR on github do it, or should this get a openvpn-devel ML
post as well ?

Christian Ehrhardt (2):
  systemd: extend CapabilityBoundingSet for auth_pam
  systemd: extend CapabilityBoundingSet for learn-address

 distro/systemd/openvpn-server@...2221... | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1


