Message-ID: <BAY17-F12E6DD05A31FCD69038A2EF9EC0@...512...>
From: "Anne Mindika Silva" <anne_mindika@...160...>
Mime-Version: 1.0
Subject: [Openvpn-devel] customizing openvpn to use other compression algorithms  - PLS HELP
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
Date: Thu Mar  9 01:55:05 2006
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

hi,

We are trying to build a network compression tool which will compress the 
data that is transfered between two machines.  While lzo, performs very well 
for text-based data, we thought it would be nice to use different 
compression algorithms for different types of data.

Since OPENVPN supports lzo compression we are using that for the initial 
version.  We also noticed that the compression is done at the packet level.  
  Is there any way that we can specify an additional compression algorithm 
to be used ?

If we have for e.g.,  basically two types to data that is sent over the 
network,  lets say one type  that compresses well with lzo, and another type 
that is better when compressed with another algorithm (or that is better off 
uncompressed),   does that mean we'll have to run two instances of OPENVPN?

Thanking in advance,

Mindika

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement


