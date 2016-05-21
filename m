Content-Type: multipart/mixed;
	boundary="Apple-Mail=_011D454E-3987-4A8D-9BB6-F7D8F035FC1F"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <20160521095734.GR53051@...1296...>
Date: Sat, 21 May 2016 12:03:12 +0200
Message-Id: <6D59C9AA-A4C2-46BE-9174-1AF245BCA90B@...2127...>
References: <5DDE3F3A-A3CA-4A68-9F23-8C4F10835E22@...2127...>
	<20160521095734.GR53051@...1296...>
Subject: Re: [Openvpn-devel] Test documentation: What does t_cltsrv.sh do?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_011D454E-3987-4A8D-9BB6-F7D8F035FC1F
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit

Gert,

please be so kind and review this README intended to go in openvpn/tests


--Apple-Mail=_011D454E-3987-4A8D-9BB6-F7D8F035FC1F
Content-Disposition: attachment;
	filename=README.md
Content-Type: text/markdown;
	name="README.md"
Content-Transfer-Encoding: 7bit

OpenVPN tests
=============

OpenVPN utilizes three types of tests
* Unit testing with cmocka
* Loopback integration testing
* VM/Server based integration testing


## Unit testing

Unit testing is described in [unit_tests](unit_tests).


## Loopback Integration testing

Loopback based tests run tests build into openvpn or tsts that do not need to
establish a tunnel with the clients packets routed through, e.g. to test that
TLS handshake works.

| Test             | Script                     | Tests what                   |
|------------------|----------------------------|------------------------------|
| TLS Handshake    | [t_cltsrv.sh](t_cltsrv.sh) | Loopback TLS handshake       |
| Crypto Loopback  | [t_lpback.sh](t_lpback.sh) | openvpn --test-crypto        |

### `t_cltsrv.sh`

`t_cltsrv.sh` is a basic TLS test that does not need external test infrastructure -
basically, it runs a test server and test client that talk to each other
via 127.0.0.1, eventually timeout and exit.

This is good to quickly see if we broke TLS handshaking (on some platform
or build combination) without having to setup a "proper" test server.



## Integration testing with dedicated servers

More extensive tests need need a dedicated test-server instance.

### Non-Standalone

These tests need some counterpart OpenVPN instance that is not definied by the 
tests.


| Test             | Script                     | Tests what                   |
|------------------|----------------------------|------------------------------|
| connectivity     | [t_client.sh](t_client.sh) | Connectivity through tunnel  |

#### `t_client.sh`

`t_client.sh` does full "see if ifconfig+route works, if everything is
properly cleaned up afterwards, and data transfer works" - but needs 
root (or sudo) privileges to test that, and a properly set up test rig.

### VM based

Integration testing with VMs is described in [server](server).

--Apple-Mail=_011D454E-3987-4A8D-9BB6-F7D8F035FC1F
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit



Cheers
Jens
--Apple-Mail=_011D454E-3987-4A8D-9BB6-F7D8F035FC1F--

