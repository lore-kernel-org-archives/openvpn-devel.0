Message-ID: <4F639D61.1060703@...1030...>
Date: Fri, 16 Mar 2012 20:06:57 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>	<1330546342-17794-36-git-send-email-alon.barlev@...277...>	<4F588784.300@...515...>	<CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>	<CAP+U6tJx_xNbEHfhENcJKEpgE1WMf-03ez=nKo2zEwUQEEe7Xw@...278...>	<CAOazyz2ESjg4vbYRqaCcT4PGdnQKw3Y77kS9UsTi2OD+_mXoSw@...278...>	<CAP+U6tJ-f9NHPCYU3H08ub2uiNhy2=ubkFXmP=fcoq0B8EptLQ@...278...>
	<CAOazyz2DZXU1m41NZ_a9==qcwKku8_xTfzSHifHJYL9Yj-B7aA@...278...>
In-Reply-To: <CAOazyz2DZXU1m41NZ_a9==qcwKku8_xTfzSHifHJYL9Yj-B7aA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 35/52] build: proper selinux detection
 and usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> However, from my experience it is not needed, people are most capable
> of manage this without creating noise.
>   
On the contrary, displaying meaningful error messages from configure is 
*never* a "noise". As Fabian pointed out - quite rightly - if make fails 
due to wrong/incorrect/missing dependencies then it is a bug in 
configure, no ifs, no buts, therefore displaying an error messages when 
some of the headers/libs are missing or misplaced makes perfect sense.


