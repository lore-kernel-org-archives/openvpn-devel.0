Message-ID: <440BDBFF.60204@...563...>
From: Ben Chelf <ben@...563...>
Reply-To: ben@...563...
MIME-Version: 1.0
Subject: [Openvpn-devel] Coverity Open Source Defect Scan of OpenVPN
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
Date: Sun Mar  5 22:52:04 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello OpenVPN Developers,

   I'm the CTO of Coverity, Inc., a company that does static source code
analysis to look for defects in code. You may have heard of us or of our
technology from its days at Stanford (the "Stanford Checker"). The
reason I'm writing is because we have set up a framework internally to
continually scan open source projects and provide the results of our
analysis back to the developers of those projects. OpenVPN is one of the
32 projects currently scanned at:

http://scan.coverity.com

   My belief is that we (Coverity) must reach out to the developers of
these packages (you) in order to make progress in actually fixing the
defects that we happen to find, so this is my first step in that
mission. Of course, I think Coverity technology is great, but I want to
hear what you think and that's why I worked with folks at Coverity to
put this infrastructure in place. The process is simple -- it checks out
your code each night from your repository and scans it so you can always
see the latest results.

   Right now, we're guarding access to the actual defects that we report
for a couple of reasons: (1) We think that you, as developers of
OpenVPN, should have the chance to look at the defects we find to patch
them before random other folks get to see what we found and (2) From a
support perspective, we want to make sure that we have the appropriate
time to engage with those who want to use the results to fix the code.
Because of this second point, I'd ask that if you are interested in
really digging into the results a bit further for your project, please
have a couple of core maintainers (or group nominated individuals) reach
out to me to request access. As this is a new process for us and still
involves a small number of packages, I want to make sure that I
personally can be involved with the activity that is generated from this
effort.

   So I'm basically asking for people who want to play around with some
cool new technology to help make source code better. If this interests
you, please feel free to reach out to me directly. And of course, if
there are other packages you care about that aren't currently on the
list, I want to know about those too.

   If this is the wrong list, my sincerest apologies and please let me
know where would be a more appropriate forum for this type of message.

Many thanks for reading this far...

-ben

  Ben Chelf
  Chief Technology Officer
  Coverity, Inc.


