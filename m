From: fragmentux <fragmentux@...277...>
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <9678ca1e-2ef6-22ff-7992-c579902fe15a@...1147...>
 <CAKuzo_gx7Y28dtT+85HtSkKMh_UMU_+ZmbPV7-CLtLSrRP6mag@...278...>
 <7c8cb31e-13be-d4d2-7833-5503d1b385c8@...1147...>
 <02c60a84-e208-d4a4-491f-d18a2dab2934@...277...>
 <6d800e7a-1e75-dfbc-6cd0-f9ee948a8a4b@...277...>
Message-ID: <80f0084c-0dde-317d-34bf-bd02d056a055@...277...>
Date: Tue, 27 Mar 2018 00:09:06 +0100
MIME-Version: 1.0
In-Reply-To: <6d800e7a-1e75-dfbc-6cd0-f9ee948a8a4b@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 21st Mar 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I am not convinced 'iperf -r' is reliable (bold claim maybe .. )

iperf3 have dropped -r in favour of -R "reverse mode"
server sends and client receives. but not both on the same run ..

After numerous hangs and some bazaar results with iperf2
i opted to upgrade to iperf3 .. still some slightly odd results
but no hangs so far ..

regards


