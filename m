From: Davide Brini <dave_br@...1278...>
Date: Sat, 12 Dec 2009 11:31:20 +0000
References: <1256844344.7529.43.camel@...1272...>
	<200911122028.07536.dave_br@...1278...> <4B21CC61.2020401@...41...>
In-Reply-To: <4B21CC61.2020401@...41...>
MIME-Version: 1.0
Message-Id: <200912121131.20556.dave_br@...1278...>
Subject: Re: [Openvpn-devel] 2.1 rc20 and multiple interfaces problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Friday 11 December 2009, James Yonan wrote:

> Try adding the "nobind" directive to your client config file.  I think
> this will solve the problem.

That seems indeed to do it. Thank you very much!

However, never in my life could I have imagined that this was due to a setting 
*on the client*. For single-homed clients, my (possibly wrong) understanding 
was that using or not using "nobind" would essentially be the same. 
Since now I'm curious, could you please kindly provide a bit more insight as 
to *why* using "nobind" on the client fixes it, and how that affects the 
server?

Thank you. 

-- 
D.

